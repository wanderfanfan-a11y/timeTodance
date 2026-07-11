#ifndef AppVersion
#define AppVersion "1.0.0"
#endif

#ifndef SourceDir
#define SourceDir "..\..\build\windows\x64\runner\Release"
#endif

#ifndef OutputDir
#define OutputDir "..\..\dist"
#endif

[Setup]
AppId={{B436C40B-3A34-4DB4-9E58-0F53DD3DF426}
AppName=tdance 定时提醒
AppVersion={#AppVersion}
AppVerName=tdance {#AppVersion}
AppPublisher=TimeToDance
DefaultDirName={localappdata}\Programs\tdance
DefaultGroupName=tdance
DisableProgramGroupPage=yes
OutputDir={#OutputDir}
OutputBaseFilename=tdance-windows-setup-{#AppVersion}
SetupIconFile=..\runner\resources\app_icon.ico
UninstallDisplayIcon={app}\tdance.exe
PrivilegesRequired=lowest
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
MinVersion=10.0
Compression=lzma2/max
SolidCompression=yes
WizardStyle=modern
CloseApplications=yes
RestartApplications=no
VersionInfoVersion={#AppVersion}.0
VersionInfoProductName=tdance
VersionInfoDescription=tdance 定时提醒安装程序
VersionInfoCompany=TimeToDance

[Languages]
Name: "chinesesimp"; MessagesFile: "compiler:Languages\ChineseSimplified.isl"
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "创建桌面快捷方式"; GroupDescription: "附加快捷方式："; Flags: unchecked

[Files]
Source: "{#SourceDir}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{autoprograms}\tdance"; Filename: "{app}\tdance.exe"
Name: "{autodesktop}\tdance"; Filename: "{app}\tdance.exe"; Tasks: desktopicon

[Run]
Filename: "{app}\tdance.exe"; Description: "启动 tdance"; Flags: nowait postinstall skipifsilent
