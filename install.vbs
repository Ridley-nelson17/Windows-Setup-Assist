Option Explicit
Dim WSH, FSO, PATH: Set WSH = WSCript.CreateObject("wscript.shell") : Set FSO = CreateObject("Scripting.FileSystemObject")
PATH = "C:\ProgramData\WindowsSetupRestore"

If (WScript.Arguments.length = 0) Then
   Dim app: Set app = CreateObject("Shell.Application")
   app.ShellExecute "wscript.exe", Chr(34) & WScript.ScriptFullName & Chr(34) & " uac", "", "runas", 1
Else
    Main
End If
Function DownloadFile(url, filename)
     If (FSO.FolderExists(PATH)) Then
        WSH.Run "powershell -WindowStyle hidden cd " & PATH & "; Import-Module bitstransfer; start-bitstransfer -source " & url & " -destination " & PATH & "\" & filename & "; Start-Process -FilePath " & filename
    Else
        FSO.CreateFolder PATH
        DownloadFile url, filename
    End If
End Function

Function RunWithArgs
    If (FSO.FolderExists(PATH))
End Function


Function RunNoArgs(link, filename)
    Select Case MsgBox("Install """ & filename & """?", vbYesNo + vbQuestion, "Windows Restore Setup")
        Case vbYes
            MsgBox "Installing """ & filename & """.", 0+64
            DownloadFile link, filename
        Case vbNo
            MsgBox "Skipping """ & filename & """.", 0+48
    End Select
End Function

Function Main
    RunNoArgs "https://sg-public-api.hoyoverse.com/event/download_porter/link/ys_global/genshinimpactpc/default", "GenshinImpactSetup.exe"
    RunNoArgs "https://www.7-zip.org/a/7z2201-x64.exe", "7zipSetup.exe"
    RunNoArgs "https://www.gpg4win.org/thanks-for-download.html", "gpg4winSetup.exe"
    ' RunNoArgs "https://cdn-fastly.obsproject.com/downloads/OBS-Studio-29.1.3-Full-Installer-x64.exe", "OBSSetup.exe"
    RunNoArgs "https://launcher-public-service-prod06.ol.epicgames.com/launcher/api/installer/download/EpicGamesLauncherInstaller.msi", "EpicGamesLauncherSetup.msi"
    ' DownloadFile "https://ubi.li/4vxt9", "UbisoftConnectSetup.exe"
    RunNoArgs "https://cdn.akamai.steamstatic.com/client/installer/SteamSetup.exe", "SteamSetup.exe"
    RunNoArgs "https://central.github.com/deployments/desktop/desktop/latest/win32", "GithubDesktopSetup.exe"
    RunNoArgs "https://launcher.mojang.com/download/MinecraftInstaller.exe", "MinecraftLauncherSetup.exe"
    WSH.Run "powershell [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-Expression ""& { $(Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/mrpond/BlockTheSpot/master/install.ps1') } -UninstallSpotifyStoreEdition -UpdateSpotify"""

    ' DownloadFile "https://github.com/Ridley-nelson17/Windows-Setup-Assist/blob/main/ChromeSetup.exe?raw=true", "ChromeSetup.exe"
    ' DownloadFile "https://download.scdn.co/SpotifyFullSetup.exe", "SpotifySetup.exe"
    RunNoArgs "https://discord.com/api/downloads/distributions/app/installers/latest?channel=stable&platform=win&arch=x86", "DiscordSetup.exe"
'  WSH.Run "powershell cd " & PATH & "; (new-object System.Net.WebClient).DownloadFile(https://www.google.com/chrome/thank-you.html?statcb=0&installdataindex=empty&defaultbrowser=0'','" & PATH & "\""Google Chrome"".exe')"
End Function

Function DeleteTempFiles
    DeleteFolder PATH
End Function