import 'package:flutter/material.dart';

/// 全局 Navigator key：托盘菜单等运行在 Widget 树之外的回调，
/// 需要借助它来弹出对话框或访问当前 BuildContext。
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
