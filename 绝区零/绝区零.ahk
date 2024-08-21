#include "../basic/basic.ahk"
#Include 零号业绩.ahk
#Include 拿命验收.ahk
#HotIf WinActive("绝区零 ahk_class UnityWndClass")
~^Numpad0:: 零号业绩循环()
~^Numpad1:: 拿命验收()
~^0:: 零号业绩循环()
~^1:: 拿命验收()
~AppsKey & Numpad0:: t0()
~AppsKey & Numpad1:: t1()
Space:: sendstd(["RButton", "LButton", "Space"], 25, 25) ;闪a 空
c:: sendstd(["RButton", "LButton", "c"], 25, 25) ;闪a c
Delete::zzz_discard()
#HotIf

zzz_discard(){
    block_click(1744,52,0)
}
t0() {
    res:=mwaitpix([
        [1455,345,0x8A61A4,16],
        [1475,420,0x2D363D,16],
    ],0,1,,100)
    tip res
}
t1() {
    tip 11111
}
; ttt(){
;     InstallKeybdHook
;     InstallMouseHook
;     KeyHistory
; }
