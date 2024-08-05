#HotIf WinActive("绝区零 ahk_class UnityWndClass")
^Numpad0::零号业绩循环()
^Numpad1::拿命验收循环()
^0::拿命验收循环()
^Numpad2::零号刷特殊区域()
!Numpad0::t()
; #Numpad0::ttt()
#HotIf
#Include 零号业绩.ahk
#Include 拿命验收.ahk

t(){
    tip "点击确认"
    SendEvent "{Click 1402 800 Down}{click 1402 300 Up}" ;比input兼容性强
    ; MouseClickDrag "left", 1402, 800, 1402, 400
}

; ttt(){
;     InstallKeybdHook
;     InstallMouseHook
;     KeyHistory
; }