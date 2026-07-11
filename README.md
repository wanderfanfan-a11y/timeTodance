# tdance

tdance 是一款 Windows 桌面定时提醒应用，支持一次性、倒计时、间隔、
每日和每周提醒，以及可选的 5–10 分钟强制休息蒙层。

## Windows 下载

每个正式版本提供：

- `tdance-windows-setup-<version>.exe`：当前用户安装包，不需要管理员权限。
- `tdance-windows-portable-<version>.zip`：绿色版，完整解压后运行
  `tdance.exe`。
- `SHA256SUMS.txt`：安装包和绿色版的 SHA-256 校验值。

安装程序默认安装到 `%LOCALAPPDATA%\Programs\tdance`。应用数据保存在
Windows 用户应用支持目录，升级和卸载安装程序不会主动删除定时器数据库。

当前产物未进行 Authenticode 代码签名，Windows SmartScreen 可能在首次运行时
显示未知发布者提示。

## 开发

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test
```

Windows Release 构建：

```powershell
flutter build windows --release
```

## 本地打包

Windows 主机需要 Flutter、Visual Studio C++ 桌面工具链和 Inno Setup 6。

```powershell
.\tool\package_windows.ps1
```

脚本从 `pubspec.yaml` 读取版本，在 `dist` 中生成安装包、绿色 ZIP 和校验文件。

## 发布

1. 在 `pubspec.yaml` 更新 `version: major.minor.patch+build`。
2. 合并通过 Windows CI 的修改。
3. 创建并推送相同版本的标签，例如 `v1.0.0`。
4. `Flutter Windows` workflow 会验证版本、构建和测试两种产物，并自动创建
   GitHub Release。
