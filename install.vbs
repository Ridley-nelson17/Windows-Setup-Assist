Option Explicit
Dim WSH, FSO, PATH: Set WSH = WSCript.CreateObject("wscript.shell") : Set FSO = CreateObject("Scripting.FileSystemObject")
PATH = "C:\ProgramData\CWS"

If (WScript.Arguments.length = 0) Then
   Dim objShell: Set objShell = CreateObject("Shell.Application")
   objShell.ShellExecute "wscript.exe", Chr(34) & WScript.ScriptFullName & Chr(34) & " uac", "", "runas", 1
Else
    Main
End If

Function DownloadFile(url, filename)
     If (FSO.FolderExists(PATH)) Then
        WSH.Run "powershell cd " & PATH & "; Import-Module bitstransfer; start-bitstransfer -source " & url & " -destination " & PATH & "\" & filename
    Else
        FSO.CreateFolder PATH
        DownloadFile url, filename
    End If
End Function

Function Main
   DownloadFile "https://central.github.com/deployments/desktop/desktop/latest/win32", "GithubDesktopSetup.exe"
   DownloadFile "https://launcher.mojang.com/download/MinecraftInstaller.exe", "MinecraftLauncherSetup.exe"
   DownloadFile "https://github.com/Ridley-nelson17/CWS/blob/main/ChromeSetup.exe?raw=true", "ChromeSetup.exe"
   DownloadFile "https://github.com/Ridley-nelson17/CWS/blob/main/SpotifySetup.exe?raw=true", "SpotifySetup.exe"
'    WSH.Run "powershell cd " & PATH & "; (new-object System.Net.WebClient).DownloadFile(https://www.google.com/chrome/thank-you.html?statcb=0&installdataindex=empty&defaultbrowser=0'','" & PATH & "\""Google Chrome"".exe')"
End Function