#include "../basic/basic.ahk"
#HotIf WinActive("星穹铁道 ahk_class UnityWndClass")
Insert:: 星铁上锁()
Delete:: 星铁弃置()
End:: 星铁弃置1()
~AppsKey & Numpad0:: 星铁t0()
~AppsKey & Numpad1:: 星铁t1()
^`:: 星铁t0()
^1:: 星铁t1()
PgDn & Numpad7:: help星铁
#HotIf
; #CapsLock:: help星铁

星铁弃置() { ; 背包遗器界面
  block_click(440, 327, 0)
}
星铁弃置1() { ; 角色装备节界面
  block_click(1860, 255, 0)
}
星铁上锁() {
  block_click(438, 275, 0)
}
help星铁() {
  ; 有狂点快速过(开发时)和自动悠闲过
  ; 过各种对话,点到各种框,全屏幕模式默认放在最右侧
  loop {
    A_CoordModeToolTip := "Screen"
    A_CoordModePixel := "Screen"
    A_CoordModeMouse := "Screen"
    ; 5137,567,0xFFFFFF
    ; 5137,641,0xFFFFFF
    ; 5137,715,0xFFFFFF
    ToolTip "help星铁: 闲", 1920 * 1, 0, 20
    if (mgetpix([[2879, 1007, 0xD3C294, 6], [2067, 60, 0xF1D599, 6]])) { ;对话中
      ToolTip "help星铁: 对话中", 1920 * 1, 0, 20
      block_click(2879, 1007)
      ; send "{alt down}"
      ; send "{alt up}"
    }
    else if (mgetpix([[3168,553,0x98835A, 16], [3167,586,0x98835A, 16]])) { ;对话选项从上往下选3
      block_click(3288,568)
    }
    else if (mgetpix([[3167, 659, 0x99835A, 16], [3167, 692, 0x98835B, 16]])) { ;对话选项从上往下选2
      block_click(3288, 675)
    }
    else if (mgetpix([[3168, 774, 0x867C70, 16], [3168, 740, 0x98835B, 16]])) { ;对话选项1
      block_click(3288, 761)
    }
    else if (mgetpix([[3168,748,0xF1D599, 16], [3169,763,0xEFD398, 16]])) { ;对话选项1
      block_click(3293,754)
    }
    ; else if (mgetpix([[3766,50,0xFFFFFF, 6], [3781,65,0xFFFFFF, 6]])) { ;对话选项1
    ;   block_click(3781,65)
    ; }
    sleep 250
  }
}
星铁t0() {
  ; waitpix 911,911,0xE7E7E7
  ; click 911, 911
  ; sleep 300
  loop {
    waitpix 72, 67, 0xEBD19B, 18
    click 963, 754
    sleep 200
    click 128, 178
    sleep 500
    click 1536, 961
    sleep 1200
    click 1608, 984
    sleep 1200
    click 418, 501 ; 虚无633,542  记忆418,501  丰饶856,540
    sleep 600
    click 1581, 985
    sleep 5000
    loop 60 {
      click 959, 895
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
    block_click 1080, 552, 0
    sleep 200
    block_click 1699, 973, 0
    sleep 800
  }
  tmpfn1() {
    block_click 1451, 960, 0
    sleep 300
    block_click 1162, 671, 0
    sleep 4000
    loop 15 {
      block_click 1716, 1026, 0
      sleep 100
    }
    星铁t0()
  }
}
星铁t1() {
  乱选祝福与退出()
}