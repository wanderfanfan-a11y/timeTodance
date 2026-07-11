---
name: testing-forced-rest
description: Test the tdance forced-rest lifecycle, emergency shortcut, persistence migration, and Windows build. Use when changing forced-rest scheduling, overlay behavior, or recovery.
---

# Testing forced rest

## Devin Secrets Needed

None.

## Automated verification

Run from the repository root:

```bash
flutter test test/rest_overlay_test.dart --reporter expanded
flutter test test/rest_mode_service_test.dart --reporter expanded
flutter test test/database_migration_test.dart --reporter expanded
flutter test --reporter expanded
flutter analyze
```

If Flutter is not on `PATH`, use:

```bash
"$HOME/flutter/bin/flutter"
```

The focused tests should verify:

- `Ctrl + Shift + F12` requires one continuous 10-second hold.
- Releasing a required key resets emergency-exit progress.
- The overlay ends automatically at its deadline.
- Active sessions restore, expired sessions clear, and duration stays within 5–10 minutes.
- Concurrent exit requests perform one window exit and one storage clear.
- Failed window exit retains recovery data for a retry.
- The v1 database migration preserves legacy timers and installs forced-rest defaults.

## Windows CI

Check the `Flutter Windows / build` workflow and confirm these steps pass:

1. Drift generated-file verification.
2. `flutter analyze`.
3. `flutter test`.
4. `flutter build windows --release`.
5. Windows artifact upload.

Do not treat a successful Windows compile as proof of native GUI behavior.

## Windows manual acceptance

Use a Windows 10 or Windows 11 host, preferably with two displays:

1. Create a countdown timer with forced rest enabled and a 5-minute duration.
2. Confirm the 10-second preparation notification appears before the overlay.
3. Confirm the overlay spans the virtual desktop and stays topmost.
4. Try normal close, minimize, maximize, Alt+F4, Win+D, and app switching.
5. Release the emergency shortcut before 10 seconds and confirm progress resets.
6. Hold `Ctrl + Shift + F12` continuously for 10 seconds and confirm the desktop returns.
7. Repeat while changing display resolution, DPI, or connected displays.
8. Restart the app during an active session and confirm the remaining session restores.

Windows secure-desktop behavior such as `Ctrl+Alt+Del` should remain available and must not be described as blocked.
