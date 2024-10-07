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
Insert:: zzz_lock()
#HotIf

zzz_discard() {
  block_click(1826,51, 0)
}
zzz_lock(){
  block_click(1741,53, 0)
}
t0() {
  零号业绩_路线分析()
}
t1() {
  waitpix 1350, 485, 0xE67772, 24, 1 ; s门
  waitpix 1359,789,0x296CFC, 6, 1, () => click(1383, 487), 1000 ;s门对话框，前往s门
  waitpix 1359,789,0x296CFC, 6, -2, () => click(1400,789) ;s门对话框，点掉对白
  sleep 1000
  waitpix 1348, 487, 0x1E2629, 10, 3, () => click(1487, 375) ;s门空
  零号业绩_giveup()
}
; ttt(){
;     InstallKeybdHook
;     InstallMouseHook
;     KeyHistory
; }
