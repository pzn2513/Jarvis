﻿#include "../basic/basic.ahk"
零号业绩已达上限 := false
零号业绩循环() {
  loop {
    ; if(零号业绩已达上限){
    ;     global 零号业绩已达上限:=false
    ;     msgbox "零号业绩已达上限,结束循环"
    ;     break
    ; }
    零号业绩()
  }
}
零号业绩() {
  WinActivate("绝区零 ahk_class UnityWndClass")
  waitpix 665, 700, 0x7838CE, 6 ;主界面
  waitpix 665, 700, 0x7838CE, 6, -2, () => click(700, 700) ;主界面
  waitpix 1632, 380, 0xADE105, 6 ;列车2
  click(1632, 380)
  temp_func() {
    click(1734, 1027)
    Sleep 100
    click(1169, 627)
  }
  waitpix 1704, 1027, 0xFFFFFF, 6, -10, () => temp_func() ;确认-出战
  mwaitfunc([
    [() => getpix(952, 792, 0xFFFFFF), () => start_minghui(true)],
    [() => mgetpix([[210, 46, 0x4F4F4F], [1310, 349, 0xFAFAFA]]), () => start_minghui(false)],
  ], "开场有无鸣徽")
  start_minghui(minghui) {
    if (minghui) {
      waitpix 952, 792, 0xFFFFFF, 6, -2, () => click(980, 792) ;选择鸣徽
      waitpix 1345, 355, 0xFFFFFF, 6, 1, () => click(1400, 678) ;对话框
      waitpix 210, 49, 0xFCE802, 6, 1, () => click(1400, 678) ;加速
    } else {
      waitpix 1345, 355, 0xFFFFFF, 6, 1, () => click(1400, 678) ;对话框
      waitpix 210, 49, 0xFCE802, 6, 1, () => click(1400, 678) ;加速
    }
  }
  sleep 2000
  ; 分析路线 1316, 225,0x324147
  零号业绩_路线分析()
}
零号业绩_路线分析() {
  mwaitfunc([
    [() => mgetpix([[1258, 797, 0x6A7882, 24], [1441, 144, 0x343B46, 16]]),
    零号业绩_上路],
    [() => mgetpix([[1290, 867, 0xED242B, 48], [1316, 867, 0xED232C, 48]]), 零号业绩_下路], ;黄点红点
    [() => mgetpix([[1257, 216, 0x4D6972, 16], [1423, 767, 0x2C2530, 16]]), 零号业绩_下路
    ],
    [() => mgetpix([[994, 240, 0x7E5346, 16], [1380, 877, 0x223534, 16]]), 零号业绩_下路],
    [() => mgetpix([[1309, 163, 0x241E1A, 16], [1230, 881, 0x151E26, 16]]), 零号业绩_下路],
  ], "路线分析")
}
零号业绩_上路() {
  WinActivate("绝区零 ahk_class UnityWndClass")
  tip "零号业绩_上路"
  ; waitpix 1140,532,0x581B1B,30,1
  ; waitpix 1140,532,0x581B1B,30,-1,()=>sendstd("r",800,800)
  Sleep 600
  sendstd "r", 500, 500
  waitpix 952, 792, 0xFFFFFF, 6, 1, () => sendstd("d") ;选择鸣徽
  waitpix 952, 792, 0xFFFFFF, 6, -2, () => click(980, 792) ;选择鸣徽
  ; waitpix 1275, 442, 0xABAAAE, 20, 1, () => sendstd("d")
  waitpix 1384, 785, 0xC01C00, 6, 1, tmpfn ;关键进展，之前
  tmpfn(){
    sendstd("d")
    sendstd("w")
  }
  零号业绩_battle()
  零号业绩_get_reward()
}
零号业绩_下路() {
  WinActivate("绝区零 ahk_class UnityWndClass")
  tip "零号业绩_下路"
  waitpix 1291, 363, 0x343334, 0, 1, () => sendstd("s") ;聊天框
  waitpix 1360, 599, 0x47EB55, 6, 1, () => click(1499, 537) ;接受支援
  waitpix 849, 619, 0x00CC0D, 6, 1, () => click(1499, 537) ;接受支援
  waitpix 849, 619, 0x00CC0D, 6, -2, () => click(974, 623) ;加入队伍
  Sleep 600
  sendstd "r", 500, 500
  waitpix 952, 792, 0xFFFFFF, 6, 1, () => sendstd("s") ;选择鸣徽
  waitpix 952, 792, 0xFFFFFF, 6, -2, () => click(980, 792) ;选择鸣徽
  waitpix 1384, 785, 0xC01C00, 6, 1, () => sendstd("d") ;关键进展，之前
  零号业绩_battle()
  零号业绩_get_reward()
}
零号业绩_battle() {
  waitpix 1384, 785, 0xC01C00, 6 ;进入战斗
  waitpix 1384, 785, 0xC01C00, 6, -2, () => click(1484, 785) ;进入战斗
  Sleep 5000
  WinActivate("绝区零 ahk_class UnityWndClass")
  waitpix 1563, 963, 0x979697, 6 ;战斗开始 灰色闪避
  零号业绩_容易出错()
  waitpix 952, 792, 0xFFFFFF, 6 ;选择鸣徽
  waitpix 952, 792, 0xFFFFFF, 6, -2, () => click(980, 792) ;选择鸣徽
}
零号业绩_容易出错() {
  timeout:=mwaitfunc([
    ; [() => mgetpix([[1020, 953, 0x00CC0D, 12], [1020, 965, 0x0A0A0A, 12]]), () => waitpix(1020, 953, 0x00CC0D, 6, -2, () => click(1158, 960))],
    ; [() => mgetpix([[1020, 1008, 0x111111, 6], [1019, 1017, 0x00CC0D, 12]]), () => waitpix(1019, 1017, 0x00CC0D, 6, -2, () => click(1158, 1017))],
    ; [() => mgetpix([[582, 396, 0x089A31, 12], [1188, 906, 0xFFFFFF, 6]]), () => waitpix(1019, 1017, 0x00CC0D, 6, -2, () => click(1153, 894))],
    ; new 以后注释上面，能成功完成流程可以去掉
    [() => mgetpix([[582,297,0x7BFE00, 12], [1021,946,0x00CC0D, 6]]), () => waitpix(1019, 1017, 0x00CC0D, 6, -2, () => click(1153, 894))],
    [() => mgetpix([[582,264,0x7BFE00, 12], [1020,979,0x00CC0D, 6]]), () => waitpix(1019, 1017, 0x00CC0D, 6, -2, () => click(1155,964))],
    ; 586,393,0x75EC03 1021,847,0x00CC0D
    ; [() => mgetpix([[584,360,0x72ED03, 12], [1018,880,0x00CC0D, 6]]), () => waitpix(1019, 1017, 0x00CC0D, 6, -2, () => click(1159,867))], ;到这阶段已经打完奖励
  ], "战斗", 1, 零号业绩_shark_fight,,80000)
  if(timeout=="timeout"){
    msgbox_autoclose timeout
  }
}
零号业绩_shark_fight() {
  ; dw right left*10
  send("{d Down}")
  sleep 30
  send("{w Down}")
  sleep 30
  click "R D"
  sleep 260
  click "R U"
  sleep 30
  send("{d Up}")
  sleep 30
  loop 7 {
    click
    sleep 100
  }
  send("{w Up}")
  if (getpix(850, 622, 0x00CC0D)) { ;提示周期内达到上限
    click 900, 622
    sleep 300
  }
}
零号业绩_get_reward() {
  ; 如果没业绩，直接结束
  waitpix 1363, 587, 0x946A5F, 16
  res := mwaitpix([[1457, 368, 0x7459A6, 16], [1555, 356, 0x6451A0, 16]], 0, 1, , , 500)
  if (res == "timeout") {
    ; tip 1
    ; sleep 99999
    零号业绩_giveup()
  } else {
    ; tip 2
    ; sleep 99999
    mwaitpix [[210, 52, 0x4F4F4F, 6], [1343, 359, 0xD6D6D6, 6]], 0, 1, () => sendstd("w")
    ; waitpix 1296,359,0x343534,6,1,()=>sendstd("w") ; ;假面研究对话出现
    ; waitpix 1290,728,0xFFFFFF,6,1,()=>click(961,807) ; ;假面研究3选项出现，选3
    ; waitpix 1290,728,0xFFFFFF,6,-1,()=>click(1490,734)
    fn() {
      click(961, 807)
      sleep 50
      click(1490, 734)
    }
    waitpix 210, 49, 0xFCE802, 6, 1, () => fn() ;加速
    ; waitpix 1350,485,0xE67772,20,1,()=>fn() ; s门,点掉对白
    waitpix 1350, 485, 0xE67772, 24, 1 ; s门
    waitpix 1359, 789, 0x296CFC, 6, 1, () => click(1383, 487), 1000 ;s门对话框，前往s门
    waitpix 1359, 789, 0x296CFC, 6, -2, () => click(1400, 789) ;s门对话框，点掉对白
    fn0() {
      sendstd "d"
      sendstd "w"
    }
    mwaitpix([[1457, 368, 0x7459A6, 16], [1555, 356, 0x6451A0, 16]], 0, -2, fn0, , 2500)
    ; waitpix 1348, 487, 0x1E2629, 10, 4, () => click(1487, 375) ;s门空
    零号业绩_giveup()
  }
}
零号业绩_giveup() {
  waitpix 1594, 1027, 0xCB0000, 6, 1, tmpfn, 300
  tmpfn() {
    click 962, 780
    sendstd("esc")
  }
  waitpix 1120, 627, 0xF8F8F8, 6, 1, () => click(1594, 1027), 200 ;确认前,点放弃
  ; sleep 150
  waitpix 708, 626, 0xCB0000, 6, -1, () => click(1182,650), 200 ;确认
  waitpix 1690, 1030, 0xFFFFFF, 6 ;完成
  waitpix 1690, 1030, 0xFFFFFF, 6, -8, tmpfn1 ;完成
  tmpfn1() {
    click(1600, 1030)
    sleep 100
    click 701, 649
  }
  sleep 2500
}