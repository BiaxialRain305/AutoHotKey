#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance Force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
CoordMode Pixel, Client ; Recommended

=::
	counter = 0 
	start:
	Loop {
		send $kl 10{Enter}
		Random, rand, 2.2, 3.2
		rand := rand * 1000
		sleep %rand%
		if (counter == 1 and A_Min == 58) 
		{
			counter := 0
		}
	} until A_Min == 57 and counter == 0
	counter = 1
	send $arlp{Enter}
	sleep %rand%
	send $arlp{Enter}
	sleep %rand%
	send $arlp{Enter}
	sleep %rand%
	send $arlp{Enter}
	sleep %rand%
	send $arlp{Enter}
	sleep %rand%
	gosub start
-::
ExitApp
	

	