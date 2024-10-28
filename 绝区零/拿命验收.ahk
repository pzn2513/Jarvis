#include "../basic/basic.ahk"
拿命验收_主循环() {
  ; 删除当前目录下的log.txt
  filename := "拿命验收log.txt"
  if (FileExist(filename)) {
    FileDelete(filename)
  }
  times := 0
  loop {
    if (拿命验收()) {
      times++
      Loop Files, "拿命验收*." {
        FileDelete(A_LoopFilePath)
      }
      FileAppend "", "拿命验收" times
    }
    sleep 4000
  }
}
拿命验收() {
  ; WinActivate "绝区零 ahk_class UnityWndClass"
  拿命验收_主判()
  waitpix(1630, 846, 0xF741A5, 6) ;HDD列表
  count := 0
  while (!mgetpix([[1141, 599, 0xABABAB, 6], [1140, 599, 0x000000, 6]])) {
    ; mgetpix其它辅助点 ,[1123,614,0x5C5C5C,6],[1102,612,0xD1D1D1,6]
    ; MouseClickDrag "left", 1402, 800, 1402, 400 ;上划
    SendEvent("{Click 1402 880 Down}{click 1402 10 Up}")
    sleep 500
    count++
    if (count > 3) {
      click 113, 50
      sleep 1500
      click 1659, 58
      sleep 500
      click 1659, 268
      sleep 2500
      count := 0
      拿命验收_主判()
      ; break
    }
  }
  click 1334, 599
  sleep 100
  click 1719, 1035
  waitpix(1726, 49, 0xcccccc, 6, -25, () => click(1719, 1035), 200) ;队伍
  /*
  打箱子精细操作
  */
  ; WinActivate "绝区零 ahk_class UnityWndClass"
  waitpix 1563, 963, 0x979697, 0 ;战斗开始 灰色闪避
  Send "{w Down}"
  Sleep 250
  Click "R D"
  Sleep 100
  Click "R U"
  Sleep 300
  Click "D"
  Sleep 100
  Click "U"
  Sleep 200
  Send "{Space Down}"
  Sleep 100
  Send "{Space Up}"
  Sleep 100
  Click "R D"
  Sleep 300
  Send "{d Down}"
  Sleep 1350
  Send "{d Up}"
  Sleep 1200
  Send "{d Down}"
  res := waitpix(969, 815, 0xFFFFFF, 0, 3, () => sendstd("f", 100), 100, 6000) ;完成
  Send "{d Up}"
  Sleep 10
  Send "{w Up}"
  Sleep 10
  Click "R U"
  if (res == "timeout") {
    拿命验收_giveup()
    return 0
  } else {
    waitpix 1690, 1030, 0xFFFFFF, 0, 1, () => click(1511, 662) ;完成
    waitpix 1690, 1030, 0xFFFFFF, 0, -25, () => click(1720, 1030) ;完成
  }
  ; mwaitpix [[100, 100, 0x060606, 6], [100, 1000, 0x060606, 6], [1820, 100, 0x060606, 6], [1820, 800, 0x060606, 6]], 0, -2, , , 4000 ;识别黑幕结束，4s容错
  return 1
}
拿命验收_giveup() {
  waitpix 1594, 1027, 0xCB0000, 0, 1, tmpfn, 500 ;放弃
  tmpfn(){
    click 861,796
    sleep 800
    sendstd("esc")
  }
  waitpix 1594, 1027, 0xCB0000, 0, -2, () => click(1630, 1027)
  waitpix 1120, 627, 0xF8F8F8, 0 ;确认
  waitpix 1120, 627, 0xF8F8F8, 0, -2, () => click(1120, 627) ;确认
}
拿命验收_主判() {
  res := mwaitfunc([
    [() => getpix(1630, 846, 0xF741A5, 6)],
    [() => getpix(1236, 52, 0xE4CC00, 6), () => mwaitpix([[1833, 1030, 0x313131, 6], [1116, 1002, 0x313131, 6], [1066, 1036, 0xB5B5B5, 6]], 0, 1, () => click(921, 667))],
    [() => getpix(1512, 1023, 0x1B1B1B, 6), 拿命验收_shafa],
  ], "识别位置", 1, , 200, 6000)
  if (res == "timeout") {
    拿命验收_M2HDD()
  }
}
拿命验收_shafa() {
  /*
  沙发爬起来继续，点到界面出现
  */
  ; WinActivate "绝区零 ahk_class UnityWndClass"
  ; 觉得有些累了 402,833,0x313031 1168,937,0xFFFFFF  1508,1025,0x1E1F1E
  ; waitpix(1777, 897, 0xFFFFFF, 0, 5, () => sendstd("space"))
  mwaitpix([[1777, 897, 0xFFFFFF, 6], [1809, 122, 0xF8F8F8, 6]], 0, 1, () => sendstd("space"))
  sendstd "d", 20, 400
  send "{s Down}"
  Sleep 400
  sendstd "a", 20, 500
  send "{d Down}"
  res := waitpix(1236, 52, 0xE4CC00, 6, 1, () => sendstd("f"), 100, 5000)
  send "{s Up}"
  send "{d Up}"
  if (res == "timeout") {
    拿命验收_M2HDD()
  } else {
    拿命验收_主判()
  }
}

拿命验收_M2HDD() {
  ; m档案架-》HDD
  ; WinActivate "绝区零 ahk_class UnityWndClass"
  waitpix 1775, 896, 0xFFFFFF, 0, 1, () => tmpfun(), 800
  tmpfun() {
    sendstd(["esc", "LBUTTON"])
    tip "M2HDD"
  }
  ; 如果在主界面卡住，就会出现卡死
  waitpix 1775, 896, 0xFFFFFF, 0, -1, () => sendstd("m")
  click 976, 451, 0
  Sleep 500
  ; 所以这里确认是否到地图页面，否则重跑前面
  res := mwaitpix([[206, 54, 0x090909, 6], [212, 53, 0xB1B1B1, 6], [1611, 51, 0x020202, 6], [1611, 54, 0xFFFFFF, 6]], 0, 1, , , 2000)
  if (!res) {
    拿命验收_M2HDD()
  }
  ; m入场的时候会有纯黑
  mwaitpix [[849, 642, 0x000000], [1054, 666, 0xFFFFFF]], 0, 1, () => send("{WheelUp}"), 1000
  mwaitpix [[849, 642, 0x000000], [1054, 666, 0xFFFFFF]], 0, -1, () => click(550, 985)
  waitpix 1775, 896, 0xFFFFFF, 0, 1, () => Click(1030, 622)
  sendstd "d", 20, 1300
  sendstd "s", 20, 700
  sendstd "d", 20, 400
  res := waitpix(1236, 52, 0xE4CC00, 6, 1, () => sendstd("f"), 100, 5000)
  if (res == "timeout") {
    拿命验收_M2HDD()
  } else {
    拿命验收_主判()
  }
}