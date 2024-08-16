#include "../basic/basic.ahk"
#Include 零号业绩.ahk
#Include 拿命验收.ahk
#HotIf WinActive("绝区零 ahk_class UnityWndClass")
~^Numpad0:: 零号业绩循环()
~^Numpad1:: 拿命验收()
~^0:: 拿命验收()
~^Numpad2:: 零号刷特殊区域()
~AppsKey & Numpad0:: t0()
~AppsKey & Numpad1:: t1()
Space:: sendstd(["RButton", "LButton", "Space"], 25, 25) ;闪a 空
c:: sendstd(["RButton", "LButton", "c"], 25, 25) ;闪a c
; RButton::前向闪避() ;闪a 空
; RButton Up::sendstd("LButton") ;闪a 空
; 前向闪避(){
;     send "{w Down}"
;     ; sleep 30
;     send "{RButton Down}"
; }
; 前向闪避up(){
;     send "{w Up}"
;     ; sleep 30
;     send "{RButton Up}"
; }
; RButton::sendstd("w") ;闪a 空
; #Numpad0::ttt()
#HotIf


t0() {
    mwaitfunc([
        [() => mgetpix([[1440, 67, 0x353C44, 16], [1319, 226, 0xF63C3D, 32]])],
        [() => mgetpix([[1429, 903, 0x1A2028, 16], [1321, 886, 0xEB2429, 32]])],
    ], "路线分析")
}
t1() {
    sendstd ["esc", "LBUTTON"]
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
