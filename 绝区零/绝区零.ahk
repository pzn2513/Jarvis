#HotIf WinActive("绝区零 ahk_class UnityWndClass")
^Numpad0::零号业绩循环()
^Numpad1::拿命验收循环()
^0::拿命验收循环()
^Numpad2::零号刷特殊区域()
AppsKey & Numpad0::t()
; #Numpad0::ttt()
#HotIf
#Include 零号业绩.ahk
#Include 拿命验收.ahk

t(){
    waitpix 210,46,0xE3E3E3,0,-1,()=>sendstd("alt") ;入场，按alt加速
}

; ttt(){
;     InstallKeybdHook
;     InstallMouseHook
;     KeyHistory
; }