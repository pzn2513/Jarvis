#HotIf WinActive("绝区零 ahk_class UnityWndClass")
~^Numpad0::零号业绩循环()
~^Numpad1::拿命验收()
~^0::拿命验收()
~^Numpad2::零号刷特殊区域()
~AppsKey & Numpad0::t0()
~AppsKey & Numpad1::t1()
; #Numpad0::ttt()
#HotIf
#Include 零号业绩.ahk
#Include 拿命验收.ahk

t0(){
    拿命验收()
}
t1(){
    sendstd ["esc","LBUTTON"]
    ; send "{esc Down}{sleep 100}{esc Up}"
    ; send "{esc Down}"
    ; sleep 30
    ; send "{esc Up}"
}
; ttt(){
;     InstallKeybdHook
;     InstallMouseHook
;     KeyHistory
; }