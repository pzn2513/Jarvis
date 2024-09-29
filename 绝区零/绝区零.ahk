#include "../basic/basic.ahk"
#Include 零号业绩.ahk
#Include 拿命验收.ahk
#HotIf WinActive("绝区零 ahk_class UnityWndClass")
~^Numpad0:: 零号业绩循环()
~^Numpad1:: 拿命验收_主循环()
~^0:: 零号业绩循环()
~^`:: 零号业绩循环()
~^1:: 拿命验收_主循环()
~AppsKey & Numpad0:: t0()
~AppsKey & Numpad1:: t1()
Space:: sendstd(["RButton", "LButton", "Space"], 25, 25) ;闪a 空
c:: sendstd(["RButton", "LButton", "c"], 25, 25) ;闪a c
Delete:: zzz_discard()
#HotIf

zzz_discard() {
  block_click(1744, 52, 0)
}
t0() {
  零号业绩_上路()
}
t1() {
  零号业绩_容易出错()
}
; ttt(){
;     InstallKeybdHook
;     InstallMouseHook
;     KeyHistory
; }
