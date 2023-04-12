Print(string:=""){
	Static
	string := string ? string . "`r`n" . lastStr : "", lastStr := string
	If !WinActive("ahk_class AutoHotkey"){
		ListVars
		WinWait ahk_id %A_ScriptHwnd%
		WinGetTitle, title, ahk_id %A_ScriptHwnd%
	}Else If !string{
		PostMessage, 0x112, 0xF060,,, %title% ; 0x112 = WM_SYSCOMMAND, 0xF060 = SC_CLOSE
		Return
	}
	ControlSetText Edit1, %string%, ahk_id %A_ScriptHwnd%
}

FileAppend,, %USERPROFILE%\steamfixuser
FileRead, inDataUser, %USERPROFILE%\steamfixuser


FileAppend,, %USERPROFILE%\steamfixpass
sleep 50
run, cmd.exe /c "aescrypt -d -p CHANGE_KEY %USERPROFILE%\steamfixpass.aes", , Hide
sleep 50
run, cmd.exe /c "cipher.exe /E %USERPROFILE%\steamfixpass", , Hide
FileRead, inDataPass, %USERPROFILE%\steamfixpass
sleep 50
FileDelete, %USERPROFILE%\steamfixpass




if ( A_Args[1] = "/setlogin") {

	Gui, Show, w270 h160, Set Login
	Gui, Font, s10
	Gui, Add, Text, x10 y+15 w270, Enter the Login to the steam account.
	Gui, Add, Text, x10 y+0 w270, Passwords are encrypted with AES-256.
	Gui, Add, Text, x10 y58 w50, Username:
	Gui, Add, Edit, x80 y55 w180 vUser, %inDataUser%
	Gui, Add, Text, x11 y89 w50, Password:
	Gui, Add, Edit, x80 y85 w180 Password vPass,
	Gui, Add, Button, x60 y+10 w100 h30 gGuiClose, Cancel
	Gui, Add, Button, x+0 w100 h30 gOkClick, Ok
	return
	
} else if ( A_Args[1] = "/h") {

	Print("    ")
	Print("                     Use only if steam constantly required re-auth such as when using a VPN")
	Print("    /setlogin      Open GUI that stores username and password to pass it to steam on launch")
	Print("    ")
	Print("    /n                Does not launch steam after killing it.")
	Print("    /h                Help.")
	Print("    ")
	Print("    ")
	Print("    steamfix [arguments]")
	Print("    ")
	Print(" Here is some documentation for this horible program:")
	Print(" SteamFix is a bash script writen by Rory and compiled with shc")
	Print("    ")
	Print(" YourBoyRory ")
	Print(" Organized Web Operations ")
	Print("   \___/  \_/\_/  \___/   ")
	Print("  | |_| |\ V  V /| |_| |  ")
	Print("  | | | \ \ /\ / / | | |  ")
	Print("   / _ \ \      / / _ \   ")
	Print("    _____        _____    ")
	Print("    ")
	
	sleep 600000
	ExitApp
	
} else {


	run, cmd.exe /c "Taskkill /IM steam.exe /F", , Hide

	if (A_Args[1] != "/n") {
		sleep 1000
		SetWorkingDir, C:\Program Files (x86)\Steam\
		Run C:\Program Files (x86)\Steam\Steam.exe -login %inDataUser% %inDataPass%

	}
	ExitApp
}





return
OkClick:
	Gui, Submit
	FileDelete, %USERPROFILE%\steamfixuser
	FileDelete, %USERPROFILE%\steamfixpass
	FileAppend, %User%, %USERPROFILE%\steamfixuser
	
	FileAppend, %Pass%, %USERPROFILE%\steamfixpass
	sleep 50
	run, cmd.exe /c "aescrypt -e -p CHANGE_KEY %USERPROFILE%\steamfixpass", , Hide
	sleep 50
	FileDelete, %USERPROFILE%\steamfixpass
	
GuiEscape:
GuiClose:
	ExitApp

