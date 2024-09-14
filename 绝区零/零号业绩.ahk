#include "../basic/basic.ahk"
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
  ; 分析路线 1316, 225,0x324147
  mwaitfunc([
    [() => mgetpix([[1440, 67, 0x353C44, 16], [1319, 226, 0xF63C3D, 32]]),
      零号业绩_上路],
    [() => getpix(1385, 887, 0xEA212C, 32), 零号业绩_下路],
    [() => getpix(1280, 850, 0xDB2325, 32), 零号业绩_下路],
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
  waitpix 1270, 470, 0xFFAF2A, 6, 1, () => click(1334, 145) ;关键进展，之前
  零号业绩_battle()
  零号业绩_get_reward()
}
零号业绩_下路() {
  WinActivate("绝区零 ahk_class UnityWndClass")
  tip "零号业绩_下路"
  waitpix 1291, 363, 0x343334, 6, 1, () => sendstd("s") ;聊天框
  waitpix 1360, 599, 0x47EB55, 6, 1, () => click(1499, 537) ;接受支援
  waitpix 849, 619, 0x00CC0D, 6, 1, () => click(1499, 537) ;接受支援
  waitpix 849, 619, 0x00CC0D, 6, -2, () => click(974, 623) ;加入队伍
  waitpix 942, 784, 0xDBB5B8, 16
  Sleep 600
  sendstd "r", 500, 500
  waitpix 952, 792, 0xFFFFFF, 6, 1, () => sendstd("s") ;选择鸣徽
  waitpix 952, 792, 0xFFFFFF, 6, -2, () => click(980, 792) ;选择鸣徽
  waitpix 1270, 470, 0xFFAF2A, 6, 1, () => click(1333, 813) ;关键进展，之前
  零号业绩_battle()
  零号业绩_get_reward()
}
零号业绩_battle() {
  waitpix 1360, 598, 0xD9D8D9, 6 ;确认继续
  waitpix 1360, 598, 0xD9D8D9, 6, -2, () => click(1466, 572) ;确认继续
  Sleep 5000
  WinActivate("绝区零 ahk_class UnityWndClass")
  waitpix 1563, 963, 0x979697, 6 ;战斗开始 灰色闪避
  零号业绩_容易出错()
  waitpix 952, 792, 0xFFFFFF, 6 ;选择鸣徽
  waitpix 952, 792, 0xFFFFFF, 6, -2, () => click(980, 792) ;选择鸣徽
}
零号业绩_容易出错(){
  mwaitfunc([
    [() => mgetpix([[1020, 953, 0x00CC0D, 6], [1020, 965, 0x0A0A0A, 6]]), () => waitpix(1020, 953, 0x00CC0D, 6, -2, () => click(1158, 960))],
    [() => mgetpix([[1020,1008,0x111111, 0], [1019, 1017, 0x00CC0D, 6]]), () => waitpix(1019, 1017, 0x00CC0D, 6, -2, () => click(1158, 1017))],
  ], "战斗", 1, 零号业绩_shark_fight)
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
  WinActivate("绝区零 ahk_class UnityWndClass")
  ; waitpix 210,46,0xE3E3E3,6 ;入场，按alt加速
  ; waitpix 210,46,0xE3E3E3,6,-1,()=>sendstd("alt") ;入场，按alt加速
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
  waitpix 1316, 357, 0xFFFFFF, 6, 1, () => click(1383, 487), 1000 ;s门对话框，前往s门
  waitpix 1316, 357, 0xFFFFFF, 6, -8, () => click(1291, 363) ;s门对话框，点掉对白
  sleep 1000
  waitpix 1348, 487, 0x1E2629, 10, 3, () => click(1487, 375) ;s门空 1489,384,0x141A23
  ; res:=mwaitpix([
  ;     [1455,345,0x8A61A4,16],
  ;     [1475,420,0x2D363D,16],
  ; ],0,1,,100,2000) ;业绩紫
  ; if(res=="timeout"){
  ;     global 零号业绩已达上限:=true
  ; }else{
  ;     waitpix 1348,487,0x1E2629,10,3,()=>click(1487,375) ;s门空 1489,384,0x141A23
  ;     ; mwaitpix [[1455,345,0x8A61A4,16],[1537,356,0xB0A3DA,16]],0,-2,()=>click(1487,375) ;业绩 1489,384,0x141A23
  ; }
  零号业绩_giveup()
}
零号业绩_giveup() {
  waitpix 1594, 1027, 0xCB0000, 6, 1, tmpfn, 300
  tmpfn() {
    click 962, 800
    sendstd("esc")
  }
  waitpix 1120, 627, 0xF8F8F8, 6, 1, () => click(1594, 1027), 300 ;确认前,点放弃
  waitpix 1120, 627, 0xF8F8F8, 6, -1, () => click(1140, 627) ;确认
  waitpix 1690, 1030, 0xFFFFFF, 6 ;完成
  waitpix 1690, 1030, 0xFFFFFF, 6, -20, () => click(1600, 1030) ;完成
  sleep 2500
}