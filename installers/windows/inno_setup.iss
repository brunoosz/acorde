[Setup]
AppName=Acorde
AppVersion=0.1.0
AppPublisher=Bruno Camperlingo
AppPublisherURL=https://github.com/brunoosz/acorde
DefaultDirName={autopf}\Acorde
DefaultGroupName=Acorde
OutputDir=..\..\build\installers
OutputBaseFilename=AcordeSetup-0.1.0
Compression=lzma2
SolidCompression=yes
SetupIconFile=..\..\assets\icons\acorde-icon-1024.png
UninstallDisplayIcon={app}\acorde.exe
WizardStyle=modern
PrivilegesRequired=lowest

[Files]
Source: "..\..\build\windows\x64\runner\Release\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs

[Icons]
Name: "{group}\Acorde"; Filename: "{app}\acorde.exe"
Name: "{group}\Desinstalar Acorde"; Filename: "{uninstallexe}"
Name: "{autodesktop}\Acorde"; Filename: "{app}\acorde.exe"; Tasks: desktopicon

[Tasks]
Name: "desktopicon"; Description: "Criar atalho na &Área de Trabalho"; GroupDescription: "Atalhos:"

[Run]
Filename: "{app}\acorde.exe"; Description: "Abrir Acorde"; Flags: nowait postinstall skipifsilent
