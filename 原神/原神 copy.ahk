
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

F2::
; 获取所有屏幕的位置信息
SysGet, MonitorCount, MonitorCount
SysGet, MonitorPrimary, MonitorPrimary
MsgBox, start.
; 检查是否有至少三个屏幕
if (MonitorCount < 3) {
    MsgBox, There are less than three monitors connected.
    ExitApp
}

; 获取第三个屏幕的位置信息
SysGet, Monitor3, Monitor, 3

; 激活名为“原神”的窗口并移动到第三个屏幕
WinActivate, 原神
Sleep, 500 ; 等待窗口激活

; 移动窗口到第三个屏幕
WinMove, 原神, , Monitor3Left, Monitor3Top

; 显示窗口位置调整后的信息
WinGetPos, X, Y, Width, Height, 原神
MsgBox, Genshin Impact window moved to the third screen at coordinates (%X%, %Y%)
Return

