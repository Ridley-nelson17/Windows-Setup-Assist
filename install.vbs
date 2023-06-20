Option Explicit
Dim WSH, FSO, PATH: Set WSH = WSCript.CreateObject("wscript.shell") : Set FSO = CreateObject("Scripting.FileSystemObject")
PATH = "C:\ProgramData\WindowsSetupRestore"

If (WScript.Arguments.length = 0) Then
   Dim app: Set app = CreateObject("Shell.Application")
   app.ShellExecute "wscript.exe", Chr(34) & WScript.ScriptFullName & Chr(34) & " uac", "", "runas", 1
Else
    RunNoArgs "https://launcher.mojang.com/download/MinecraftInstaller.exe", "temp.exe"
    ' Main
End If
Function DownloadFile(url, filename)
     If (FSO.FolderExists(PATH)) Then
        WSH.Run "powershell -WindowStyle hidden cd " & PATH & "; Import-Module bitstransfer; start-bitstransfer -source " & url & " -destination " & PATH & "\" & filename & "; Start-Process -FilePath " & filename
    Else
        FSO.CreateFolder PATH
        DownloadFile url, filename
    End If
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
    DownloadFile "https://cdn.akamai.steamstatic.com/client/installer/SteamSetup.exe", "SteamSetup.exe"
    DownloadFile "https://central.github.com/deployments/desktop/desktop/latest/win32", "GithubDesktopSetup.exe"
    DownloadFile "https://launcher.mojang.com/download/MinecraftInstaller.exe", "MinecraftLauncherSetup.exe"
    DownloadFile "https://github.com/Ridley-nelson17/CWS/blob/main/ChromeSetup.exe?raw=true", "ChromeSetup.exe"
    DownloadFile "https://download.scdn.co/SpotifyFullSetup.exe", "SpotifySetup.exe"
    DownloadFile "https://discord.com/api/downloads/distributions/app/installers/latest?channel=stable&platform=win&arch=x86", "DiscordSetup.exe"
'  WSH.Run "powershell cd " & PATH & "; (new-object System.Net.WebClient).DownloadFile(https://www.google.com/chrome/thank-you.html?statcb=0&installdataindex=empty&defaultbrowser=0'','" & PATH & "\""Google Chrome"".exe')"
End Function

Function DeleteTempFiles
End Function