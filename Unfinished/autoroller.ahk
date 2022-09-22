#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance Force
SendMode Event  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
CoordMode Pixel, Client ; Recommended
SetTitleMatchMode 2
DetectHiddenWindows, On
SetKeyDelay, 25
gosub makeGUI
Gui, Show, Autosize

=::ExitApp
_:: 
	gosub PauseS
	return
-::

	StartS:
	
		loop
		{     
			Sleep 200
			WinGet, activeprocess, ProcessName, A
			WinGet, discord_id, id, A
			if (A_index > 1000) 
			{
				return
			}

		} until activeprocess == "Discord.exe" || activeprocess == "DiscordPTB.exe"
		
		Sleep 500
		counter := 0
		Loop 
		{
			Setinterval := 60 - (60 - Setinterval)
			if (A_Min = Setinterval) ; start
			{
				gosub RollChoice	
			} 
			else if (A_Min < Setinterval-1) ; 1-59 Minute < us rolls
			{ 
				gosub RollChoice
					
			} 
			else if (A_Min >= Setinterval-1 && A_Min <= Setinterval) ; just in case rolls wait (default) Setinterval-3 - Setinterval
			{
				loop 5,  
				{
					Random, randlag, 1.6, 1.7
					randlag := randlag * 1000 + 500
					Send $%rolltype% {ENTER}
					Sleep %randlag%

					if (A_Min <= Setinterval-1) 
					{
						counter := 0
						break
					}
				}
				
				loop 
				{
					Sleep 1000
					counter := 0
				} until A_Min <= Setinterval-1 ; 0
			}
		}

	RollChoice:
		if (DoubleChannel) ; FASTEST DOUBLE CHANNEL (3 $, 1 /)
		{
			Random, randlag, 1000.0, 1300.0
			if (counter == 0)
			{
				Send, /%rolltype%{Space}
				Sleep, 250
				Send, {enter}
				counter++
				
			} 
			else if (counter == 1)
			{
				Send {AltDown}{Down}{AltUp}
				sleep 500
				send $%rolltype% {ENTER}
				sleep %randlag%
				counter++
			}
			else if (counter == 2)
			{
				send $%rolltype% {ENTER}
				sleep 100
				Send {AltDown}{Up}{AltUp}
				sleep 1100
				counter := 0
			}
		}
		
		if (Fastest) ; no lag
		{
			Random, randlag, 1.0, 1.3
			randlag := randlag * 1000
			if (counter == 4) 
			{
				Send, /%rolltype%{Space}
				Sleep, 250
				Send, {enter}
				randlag += 200
				sleep %randlag%
			} 
			else if (counter == 5) 
			{
				Send, /%rolltype%{Space}
				Sleep, 250
				Send, {enter}
				randlag += 180
				sleep %randlag%
				counter := 0
			} else {
				Send $%rolltype% {ENTER}
				randlag += 110
				sleep %randlag%
			}
			counter++
			
		}

		if (Faster) ; reliable for lag
		{
			Random, randlag, 1300.0, 1500.0
			if (counter != 2) ; reliable for lag 
			{
				Send $%rolltype% {ENTER}
			} 
			else
			{
				Send, /%rolltype%{Space}
				Sleep, 250
				Send, {enter}
				counter := 0
			}
			sleep %randlag%
			counter++
		}

		
		if (Fast) ; double channel 
		{
			Random, randlag, 1200.0, 1400.0
			if (counter == 0)
			{
				Send, /%rolltype%{Space}
				Sleep, 250
				Send, {enter}
				send {AltDown}{Down}{AltUp} 
				counter++
				sleep 500
			} 
			else if (counter == 1)
			{
				send $%rolltype% {ENTER}
				gosub rollCheck
				sleep %randlag%
				send $%rolltype% {ENTER}{AltDown}{Up}{AltUp}
				counter := 0
				sleep %randlag%
			}
		}

		
		if (Alternate)
		{
			Random, randlag, 1.2, 1.3
			randlag := randlag * 1000
			if (counter == 2) 
			{
				counter := 0
				Send, /%rolltype%{Space}
				Sleep, 250
				Send, {enter}
				randlag += 200
			} 
			else if (counter == 0) 
			{
				Send, /%rolltype%{Space}
				Sleep, 350
				Send, {enter}
				randlag += 200
				
			} else {
				Send, $%rolltype%{ENTER}
				randlag += 100
			}
			sleep %randlag%
			counter++
		}
		
		gosub rollCheck
		return
	
	rollCheck:
		
		if (us && A_Min < Setinterval-1)
		{
			Pixelsearch, px, py, 733, 735, 792, 886, 0x8B343B, 10, Fast
			if (!ErrorLevel) 
			{
				Sleep 200
				Send, $us 20 {ENTER}
				Sleep 700
			}	
		}
		
		return		

makeGUI:
	Gui, New,, Autoroller
	Gui, Font, s20
	Gui, Add, Tab3,, Start|Settings|Read Me
	
	Gui, Font, s40
	
	Gui, Add, Button, gStartS w800 h100, Start
	Gui, Add, Button, vp gPauseS w800 h100, Pause
	Gui, Add, Button, gReloadS w800 h100, Reload
	Gui, Add, Button, gExitS w800 h100, Exit
	
	Gui, Font, s20
	
	Gui, Tab, 2
	Gui, add, text,, $setinterval
	Gui, Add, Edit, w600 h50
	Gui, Add, UpDown, gCheckoptions vSetinterval Range0-60, 60 (Default)
	Gui, Add, CheckBox, vus checked, Sends $us 20 after normal rolls (Doesn't waste unnecessary $us rolls)
	
	Gui, Add, Radio, gCheckoptions vDoubleChannel, Fastest Double Channel (Fastest)
	Gui, Add, Radio, gCheckoptions vFastest, Fastest (3 $, 2 /)
	Gui, Add, Radio, gCheckoptions vFaster, Faster (2 $, 1 /)
	Gui, Add, Radio, gCheckoptions vFast, Fast (1 $, 3 /)
	Gui, Add, Radio, gCheckoptions checked vAlternate, Alternate (1 $, 1 /)
	
	Gui, add, text,, Roll Type?
	Gui, Add, DropDownList, groll_type r4 vrolltype Choose1, wa|ha|wg|hg
	
	Gui, Tab, 3
	Gui, Add, Text,, Shortcuts:`n - key to Start`n _ key (shift + -) to Pause`n = key to Exit
	
	Gui, Submit, NoHide
	return

roll_type:
	rolltype := 1
	Gui, Submit, NoHide
	return

Checkoptions:
	if (Setinterval > 60)
	{
		Setinterval := 60
		GuiControl Text, Setinterval, 60
	}
	Gui, Submit, NoHide
	return

PauseS:
	pause, Toggle, 1
	If (A_IsPaused) 
	{
		GuiControl, Text, p, Unpause
	} Else {
		GuiControl, Text, p, Pause
	}
	Return
	
ReloadS:
	Reload
	return

ExitS:
	Msgbox, 4, Autoroller, Are you sure you want to exit?
	IfMsgBox, Yes
		ExitApp

	IfMsgBox, No
		return
