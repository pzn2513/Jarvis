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
Space:: sendstd(["RButton", "LButton", "Space"], 25, 25) ;闪a 空
c:: sendstd(["RButton", "LButton", "c"], 25, 25) ;闪a c
; RButton:: zzz_冲刺
Delete:: block_click(1567,52, 0)
Insert:: block_click(1487,52, 0)
#HotIf

zzz_discard() {
  block_click(1567,52, 0)
}
zzz_lock() {
  block_click(1487,52, 0)
}
t0() {
  ; 零号业绩_路线分析()
  waitpix 665, 700, 0x7838CE, 6 ;主界面
  sleep 500
  click 941,558
  sleep 600
  click 1496,53
  sleep 600
  click 1474,347
  sleep 400
  click 1716,1029
  sleep 800
  click 1738,1031
  sleep 800
  click 1111,626
  sleep 8600
  waitpix 1050,697,0xFFD400
  waitpix 1383,625,0xFFD300,6,2,()=>Click(964,796),200
  click 1505,621
  waitpix 1385,731,0xC01C00,6,1,()=>Click(1515,736)
  waitpix 279,53,0xFFFFFF,2,2,()=>Click(1515,736)
}
t1() {
  零号业绩_容易出错()
  ; 零号业绩_giveup()
  ; t0()
}
t2() {
  Loop Files, "拿命验收*." {
    FileDelete(A_LoopFilePath)
  }
}
zzz_冲刺(){
  send "{D down}"
  sleep 100
  send "{D up}"
}
; ttt(){
;     InstallKeybdHook
;     InstallMouseHook
;     KeyHistory
; }
