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
~AppsKey & Numpad2:: t2()
Space:: sendstd(["RButton", "LButton", "Space"], 20, 20) ;闪a 空
c:: sendstd(["RButton", "LButton", "c"], 20, 20) ;闪a c
Delete:: zzz_discard()
Insert:: zzz_lock()
#HotIf

zzz_discard() {
  block_click(1826, 51, 0)
}
zzz_lock() {
  block_click(1741, 53, 0)
}
t0() {
  零号业绩_路线分析()
}
t1() {
  零号业绩_giveup()
}
t2() {
  Loop Files, "拿命验收*." {
    FileDelete(A_LoopFilePath)
  }
}
; ttt(){
;     InstallKeybdHook
;     InstallMouseHook
;     KeyHistory
; }
