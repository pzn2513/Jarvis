; This script was created using Pulover's Macro Creator
; www.macrocreator.com
F11::ExitApp
F12::reload

#NoEnv
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Window
SendMode Input
#SingleInstance Force
SetTitleMatchMode 2
#WinActivateForce
SetControlDelay 1
SetWinDelay 0
SetKeyDelay -1
SetMouseDelay -1
SetBatchLines -1


!F1::
WinActivate, 原神
MoveMouseSmooth(100000, 0, 3000)
Return

MoveMouseSmooth(x, y, duration)
{
    steps := 100 ; 将移动分成100步
    stepX := x / steps
    stepY := y / steps
    stepDuration := duration / steps

    Loop, %steps%
    {
        DllCall("mouse_event", "UInt", 0x0001, "Int", stepX, "Int", stepY, "UInt", 0, "Int", 0)
        Sleep, %stepDuration%
    }
}

#IfWinActive, 原神
global Moving := false
=::
    
    {
        Moving := true
        SetTimer, MoveMouseContinuously, 10
    }
return
= UP::
    Moving := false
    SetTimer, MoveMouseContinuously, Off
return
MoveMouseContinuously:
    if (Moving) {
        DllCall("mouse_event", "UInt", 0x0001, "Int", 1000, "Int", 0, "UInt", 0, "Int", 0)
    }
return
#IfWinActive, 原神


