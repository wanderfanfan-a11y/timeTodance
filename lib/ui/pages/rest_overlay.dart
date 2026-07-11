import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../domain/models/rest_session.dart';
import '../../platform/rest/rest_mode_service.dart';

class RestOverlay extends StatefulWidget {
  final RestSession session;
  final RestModeService service;

  const RestOverlay({super.key, required this.session, required this.service});

  @override
  State<RestOverlay> createState() => _RestOverlayState();
}

class _RestOverlayState extends State<RestOverlay> {
  static const Duration _emergencyHoldDuration = Duration(seconds: 10);

  Timer? _clock;
  Timer? _emergencyTimer;
  final Stopwatch _emergencyHold = Stopwatch();
  Duration _remaining = Duration.zero;
  double _emergencyProgress = 0;

  @override
  void initState() {
    super.initState();
    _updateRemaining();
    _clock = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _updateRemaining(),
    );
  }

  @override
  void dispose() {
    _clock?.cancel();
    _emergencyTimer?.cancel();
    super.dispose();
  }

  void _updateRemaining() {
    final remaining = widget.session.endsAt.difference(DateTime.now());
    if (!mounted) return;
    setState(() {
      _remaining = remaining.isNegative ? Duration.zero : remaining;
    });
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    final keys = HardwareKeyboard.instance.logicalKeysPressed;
    final hasControl =
        keys.contains(LogicalKeyboardKey.controlLeft) ||
        keys.contains(LogicalKeyboardKey.controlRight);
    final hasShift =
        keys.contains(LogicalKeyboardKey.shiftLeft) ||
        keys.contains(LogicalKeyboardKey.shiftRight);
    final isEmergencyCombination =
        hasControl && hasShift && keys.contains(LogicalKeyboardKey.f12);

    if (isEmergencyCombination) {
      _startEmergencyHold();
    } else {
      _resetEmergencyHold();
    }
    return KeyEventResult.handled;
  }

  void _startEmergencyHold() {
    if (_emergencyTimer != null) return;
    _emergencyHold.start();
    _emergencyTimer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      final keys = HardwareKeyboard.instance.logicalKeysPressed;
      final stillHolding =
          (keys.contains(LogicalKeyboardKey.controlLeft) ||
              keys.contains(LogicalKeyboardKey.controlRight)) &&
          (keys.contains(LogicalKeyboardKey.shiftLeft) ||
              keys.contains(LogicalKeyboardKey.shiftRight)) &&
          keys.contains(LogicalKeyboardKey.f12);
      if (!stillHolding) {
        _resetEmergencyHold();
        return;
      }

      final progress =
          _emergencyHold.elapsedMilliseconds /
          _emergencyHoldDuration.inMilliseconds;
      if (progress >= 1) {
        _emergencyTimer?.cancel();
        _emergencyTimer = null;
        widget.service.emergencyExit();
        return;
      }
      if (mounted) {
        setState(() => _emergencyProgress = progress);
      }
    });
  }

  void _resetEmergencyHold() {
    _emergencyTimer?.cancel();
    _emergencyTimer = null;
    _emergencyHold
      ..stop()
      ..reset();
    if (mounted && _emergencyProgress != 0) {
      setState(() => _emergencyProgress = 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final minutes = _remaining.inMinutes;
    final seconds = _remaining.inSeconds.remainder(60);
    final countdown =
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    return PopScope(
      canPop: false,
      child: Focus(
        autofocus: true,
        onKeyEvent: _handleKeyEvent,
        child: ColoredBox(
          color: const Color(0xff101820),
          child: Stack(
            fit: StackFit.expand,
            children: [
              const _RestBackground(),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.self_improvement,
                          color: Color(0xff86d6c5),
                          size: 72,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          widget.session.taskName,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (widget.session.message.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          Text(
                            widget.session.message,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xffc7d5d2),
                              fontSize: 18,
                            ),
                          ),
                        ],
                        const SizedBox(height: 36),
                        Text(
                          countdown,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 72,
                            fontWeight: FontWeight.w300,
                            fontFeatures: [FontFeature.tabularFigures()],
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          '离开屏幕，活动身体，让眼睛休息一下',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xffa9bcb8),
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 48),
                        const Text(
                          '紧急退出：持续按住 Ctrl + Shift + F12 10 秒',
                          style: TextStyle(
                            color: Color(0xff718883),
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 280,
                          child: LinearProgressIndicator(
                            value: _emergencyProgress,
                            minHeight: 4,
                            color: const Color(0xffd98272),
                            backgroundColor: const Color(0xff2b3b3a),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RestBackground extends StatelessWidget {
  const _RestBackground();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _RestBackgroundPainter());
  }
}

class _RestBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const RadialGradient(
        colors: [Color(0xff24413d), Color(0xff101820)],
        radius: 1.1,
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(_RestBackgroundPainter oldDelegate) => false;
}
