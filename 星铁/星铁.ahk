#include "../basic/basic.ahk"
#HotIf WinActive("星穹铁道 ahk_class UnityWndClass")
Insert:: 星铁上锁()
Delete:: 星铁弃置()
End:: 星铁弃置1()
~AppsKey & Numpad0:: 星铁t0()
~AppsKey & Numpad1:: 星铁t1()
^`:: 星铁t0()
^1:: 星铁t1()
#HotIf

星铁弃置() { ; 背包遗器界面
  block_click(440,327, 0)
}
星铁弃置1() { ; 角色装备节界面
  block_click(1860,255, 0)
}
星铁上锁() {
  block_click(438,275, 0)
}
help星铁() {
  A_CoordModeToolTip := "Screen"
  A_CoordModePixel := "Screen"
  A_CoordModeMouse := "Screen"
  loop {
    ; 5137,567,0xFFFFFF
    ; 5137,641,0xFFFFFF
    ; 5137,715,0xFFFFFF
    ToolTip "help星铁", 1920 * 2, 0, 20
    if (mgetpix([[5088, 758, 0xF1D599], [5180, 757, 0xFFFFFF]])) {
      ; 对话选项1
      ; block_click(5210,577)
      ; block_click(5210,651)
      ; block_click(5210,725)
      block_click(5234, 758)
    }
    ; else if(mgetpix([[4774,966,0xAE8708],[4798,1004,0x110600]])){
    ;     ; 点击后继续
    ;     block_click(4804,599)
    ; }
    sleep 1000
  }
}
星铁t0() {
  ; waitpix 911,911,0xE7E7E7
  ; click 911, 911
  ; sleep 300
  loop {
    waitpix 72,67,0xEBD19B,18
    click 963,754
    sleep 200
    click 128,178
    sleep 500
    click 1536,961
    sleep 1200
    click 1608,984
    sleep 1200
    click 418,501 ; 虚无633,542  记忆418,501  丰饶856,540
    sleep 600
    click 1581,985
    sleep 5000
    loop 60 {
      click 959,895
      sleep 100
    }
    sleep 12000
    乱选祝福与退出()
    ; waitpix 1350,921,0xA79472
    ; loop 3{
    ;   click 1385,530
    ;   sleep 100
    ;   click 1699,973
    ;   sleep 1200
    ; }
    ; sleep 1000
    ; sendstd "esc",1000

    ; waitpix 1350,921,0xA79472
    ; click 1451,960
    ; sleep 200
    ; click 1162,671
    ; sleep 4000
    ; loop 20{
    ;   click 1716,1026
    ;   sleep 100
    ; }
  }
}
乱选祝福与退出() {
  loop {
    mwaitfunc([
      [() => mgetpix([[192, 88, 0xF0F0F0, 12], [1695, 972, 0xA8A8AB, 12]]), tmpfn0],
      [() => mgetpix([[1216, 704, 0xDBC291, 12], [1821, 712, 0xDBC291, 12]]), tmpfn1]
    ], "乱选祝福与退出")
    sleep 100
  }
  tmpfn0() {
    sleep 400
    block_click 1080, 552,0
    sleep 200
    block_click 1699, 973,0
    sleep 800
  }
  tmpfn1() {
    block_click 1451, 960,0
    sleep 300
    block_click 1162, 671,0
    sleep 4000
    loop 15 {
      block_click 1716, 1026,0
      sleep 100
    }
    星铁t0()
  }
}
星铁t1() {
  乱选祝福与退出()
}