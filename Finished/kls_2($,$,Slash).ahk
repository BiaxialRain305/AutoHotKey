#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance Force
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Event  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetKeyDelay, 30
=::
counter = 0 
start:
Loop
{
    Random, rand, 1.2, 2
    rand := rand * 1000
    Send, /kakeraloots get 10{Space}
    Sleep, 250
    Send, {enter}
    Sleep, %rand%
    rand := rand-300
    Send, $kl 10{enter}
    Sleep, %rand%
    Send, $kl 10{enter}
    Sleep, %rand%
    if (A_Min != 57 and counter == 1)
    {
        counter := 0
    }
} until A_Min == 57 and counter == 0
Random, rand, 2.2, 3.2
rand := rand * 1000
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