!define APPNAME "I2PBrowser-Launcher"
!define COMPANYNAME "I2P"
!define DESCRIPTION "This launches Firefox with a browser profile pre-configured to use i2p"
# These three must be integers
!define VERSIONMAJOR 0
!define VERSIONMINOR 0
!define VERSIONBUILD 1
# These will be displayed by the "Click here for support information" link in "Add/Remove Programs"
# It is possible to use "mailto:" links in here to open the email client

InstallDir "$PROGRAMFILES\${COMPANYNAME}\${APPNAME}"

# rtf or txt file - remember if it is txt, it must be in the DOS text format (\r\n)
LicenseData "LICENSE"
# This will be in the installer/uninstaller's title bar
Name "${COMPANYNAME} - ${APPNAME}"
Icon "firefox.launchers/windows/ui2pbrowser_icon.ico"
OutFile "install-i2pbrowser-${VERSIONMAJOR}.${VERSIONMINOR}${VERSIONBUILD}.exe"

# For removing Start Menu shortcut in Windows 7
RequestExecutionLevel admin

# start default section
Section

    # set the installation directory as the destination for the following actions
    createDirectory $INSTDIR
    SetOutPath $INSTDIR
    File firefox.launchers/windows/ui2pbrowser_icon.ico

    # Install the launcher scripts
    FileOpen $0 "$INSTDIR\i2pbrowser.bat" w
    FileWrite $0 "@echo off"
    FileWriteByte $0 "13"
    FileWriteByte $0 "10"
    FileWrite $0 'start "" "$PROGRAMFILES\Mozilla Firefox\firefox.exe" -no-remote -profile "$LOCALAPPDATA\${APPNAME}\firefox.profile.i2p"'
    FileWriteByte $0 "13"
    FileWriteByte $0 "10"
    FileWrite $0 pause
    FileWriteByte $0 "13"
    FileWriteByte $0 "10"
    FileClose $0

    FileOpen $0 "$INSTDIR\i2pbrowser-private.bat" w
    FileWrite $0 "@echo off"
    FileWriteByte $0 "13"
    FileWriteByte $0 "10"
    FileWrite $0 'start "" "$PROGRAMFILES\Mozilla Firefox\firefox.exe" -no-remote -private -profile "$LOCALAPPDATA\${APPNAME}\firefox.profile.i2p"'
    FileWriteByte $0 "13"
    FileWriteByte $0 "10"
    FileWrite $0 pause
    FileWriteByte $0 "13"
    FileWriteByte $0 "10"
    FileClose $0

    # Install the profile
    createDirectory "$LOCALAPPDATA\${APPNAME}\firefox.profile.i2p"
    SetOutPath "$LOCALAPPDATA\${APPNAME}\firefox.profile.i2p"
    File firefox.launchers/windows/firefox.profile.i2p/user.js
    File firefox.launchers/windows/firefox.profile.i2p/bookmarks.html

    # Install the extensions
    createDirectory "$LOCALAPPDATA\${APPNAME}\firefox.profile.i2p\extensions"
    SetOutPath "$LOCALAPPDATA\${APPNAME}\firefox.profile.i2p\extensions"
    File "firefox.launchers/windows/firefox.profile.i2p/extensions/{73a6fe31-595d-460b-a920-fcc0f8843232}.xpi"
    File firefox.launchers/windows/firefox.profile.i2p/extensions/https-everywhere-eff@eff.org.xpi

    SetOutPath "$INSTDIR"
    createDirectory "$SMPROGRAMS\${APPNAME}"
    CreateShortCut "$SMPROGRAMS\${APPNAME}\${APPNAME}.lnk" "C:\Windows\system32\cmd.exe" "\c $INSTDIR\i2pbrowser.bat" "$INSTDIR\ui2pbrowser_icon.ico"
    CreateShortCut "$SMPROGRAMS\${APPNAME}\Private Browsing-${APPNAME}.lnk" "C:\Windows\system32\cmd.exe" "\c $INSTDIR\i2pbrowser-private.bat" "$INSTDIR\ui2pbrowser_icon.ico"
    CreateShortCut "$DESKTOP\${APPNAME}.lnk" "C:\Windows\system32\cmd.exe" "\c $INSTDIR\i2pbrowser.bat" "$INSTDIR\ui2pbrowser_icon.ico"
    CreateShortCut "$DESKTOP\Private Browsing-${APPNAME}.lnk" "C:\Windows\system32\cmd.exe" "\c $INSTDIR\i2pbrowser-private.bat" "$INSTDIR\ui2pbrowser_icon.ico"

    # create the uninstaller
    WriteUninstaller "$INSTDIR\uninstall-i2pbrowser.exe"

    # create a shortcut to the uninstaller
    CreateShortCut "$SMPROGRAMS\${APPNAME}\Uninstall-${APPNAME}.lnk" "$INSTDIR\uninstall-i2pbrowser.exe"
SectionEnd

# uninstaller section start
Section "uninstall"

    # Uninstall the launcher scripts
    Delete $INSTDIR\i2pbrowser.bat
    Delete $INSTDIR\i2pbrowser-private.bat
    Delete $INSTDIR\ui2pbrowser_icon.ico

    # Uninstall the profile
    Delete $LOCALAPPDATA\${APPNAME}\firefox.profile.i2p\user.js
    Delete $LOCALAPPDATA\${APPNAME}\firefox.profile.i2p\bookmarks.html

    # Uninstall the extensions
    Delete "$LOCALAPPDATA\${APPNAME}\firefox.profile.i2p\extensions\{73a6fe31-595d-460b-a920-fcc0f8843232}.xpi"
    Delete "$LOCALAPPDATA\${APPNAME}\firefox.profile.i2p\extensions\https-everywhere-eff@eff.org.xpi"

    # Remove shortcuts and folders
    Delete "$SMPROGRAMS\Uninstall-${APPNAME}.lnk"
    Delete "$SMPROGRAMS\Private Browsing-${APPNAME}.lnk"
    Delete "$SMPROGRAMS\Uninstall-${APPNAME}.lnk"
    Delete "$DESKTOP\${APPNAME}.lnk"
    Delete "$DESKTOP\Private Browsing-${APPNAME}.lnk"
    rmDir "$SMPROGRAMS\${APPNAME}"
    rmDir "$LOCALAPPDATA\${APPNAME}\firefox.profile.i2p\extensions"
    rmDir "$LOCALAPPDATA\${APPNAME}\firefox.profile.i2p"
    rmDir "$LOCALAPPDATA\${APPNAME}"
    rmDir "$INSTDIR"

    # delete the uninstaller
    Delete "$INSTDIR\uninstall-i2pbrowser.exe"

# uninstaller section end
SectionEnd
