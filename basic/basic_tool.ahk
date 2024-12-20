/*
一些工具函数
*/
#include "basic_win.ahk"
tool_debug := true
debug_json := ""

; 窗口样式常量
WS_VISIBLE := 0x10000000
WS_MINIMIZE := 0x20000000
WS_MAXIMIZE := 0x01000000
WS_EX_TOOLWINDOW := 0x00000080    ; 工具窗口（不在任务栏显示）
WS_EX_APPWINDOW := 0x00040000     ; 强制在任务栏显示
CheckWindowState(hwnd) {
  if !WinExist("ahk_id " hwnd)
    return "窗口不存在"
  ; 获取窗口基本样式和扩展样式
  style := WinGetStyle("ahk_id " hwnd)
  exStyle := WinGetExStyle("ahk_id " hwnd)
  ; 获取窗口位置
  WinGetPos(&X, &Y, &W, &H, hwnd)
  ; 获取MinMax状态
  minMaxState := WinGetMinMax("ahk_id " hwnd)
  ; 检查窗口是否可见
  isVisible := (style & WS_VISIBLE) != 0
  ; 检查是否在任务栏显示
  isInTaskbar := (exStyle & WS_EX_APPWINDOW) != 0 || !((exStyle & WS_EX_TOOLWINDOW) != 0)
  ; 构建详细状态报告
  result := Map()
  result["可见性"] := isVisible ? "可见" : "隐藏"
  result["最小化"] := (style & WS_MINIMIZE) != 0 ? "是" : "否"
  result["最大化"] := (style & WS_MAXIMIZE) != 0 ? "是" : "否"
  result["任务栏显示"] := isInTaskbar ? "是" : "否"
  result["窗口位置"] := X ? "X:" X " Y:" Y : "无法获取"
  ; 综合状态判断
  if !isVisible {
    result["综合状态"] := "隐藏"
  } else if (style & WS_MINIMIZE) {
    if isInTaskbar {
      result["综合状态"] := "最小化到任务栏"
    } else {
      result["综合状态"] := "最小化到系统托盘"
    }
  } else if (X && (X = -32000 || Y = -32000)) {
    result["综合状态"] := "隐藏（特殊位置）"
  } else {
    result["综合状态"] := "正常显示"
  }

  return result
}
block_click(x, y, cross := 1) {
  ; 卡鼠标或卡按键 ctrl+alt+del可解除
  ; cross 是否跨应用
  global mX, mY, wId
  if (cross) {

    hwnd := WinExist("A")
    mouse_spy(0,"Screen")
    if (!mX) {
      MsgBox "意外：hwnd:" hwnd "，mX:" mX
    }
    BlockInput true
    A_CoordModeToolTip := "Screen"
    A_CoordModePixel := "Screen"
    A_CoordModeMouse := "Screen"    
    MouseMove x, y, 0
    ; send "{alt down}"
    sendstd "LBUTTON", 40, 5
    ; send "{alt up}"
    WinActivate hwnd
  } else {
    BlockInput true
    MouseGetPos(&mX, &mY, &wId)
    ; click x,y
    MouseMove x, y, 0
    sendstd "LBUTTON", 40, 5
  }
  MouseMove mX, mY, 0
  BlockInput false
}
waitpix(x, y, color, similar := 0, appear_times := 1, fn := () => {}, interval := 100, timeout := 0) {
  StartTime := A_TickCount
  if tool_debug
    ToolTip "waitpix " x "," y, 0, 0, 2
  global debug_json := "waitpix: " x "," y "," color "," similar "," appear_times
  num := 0
  loop {
    PixelSearch &fx, &fy, x, y, x, y, color, similar
    if (appear_times >= 0) {
      ; 可运行直到确认出现须积累的次数,0和1效果一样，都找到就退出
      if (fx != "") {
        num++
        if (num >= appear_times) {
          if tool_debug
            ToolTip "", 0, 0, 2
          return [x, y, color]
        }
      } else {
        num := 0
      }
    } else {
      ; 可运行直到确认消失须积累的次数
      if (fx == "") {
        num--
        if (num <= appear_times) {
          if tool_debug
            ToolTip "", 0, 0, 2
          return [x, y, color]
        }
      } else {
        num := 0
      }
    }
    fn()
    sleep interval
    if (timeout > 0 && A_TickCount - StartTime > timeout) {
      if tool_debug
        ToolTip "", 0, 0, 2
      return "timeout"
    }
  }
}
; waitpix如果容易误判的，就用mwaitpix加多几个pix增强可信度
mwaitpix(arr, correct_offset := 0, appear_times := 1, fn := () => {}, interval := 100, timeout := 0) {
  StartTime := A_TickCount
  if tool_debug
    ToolTip "mwaitpix " arr[1][1] "," arr[1][2], 0, 0, 2
  global debug_json := "mwaitpix: " obj2json(arr)
  ; arr:=[[x,y,color,similar],...]
  num := 0
  loop {
    correct := []
    for k, v in arr {
      if (!v.Has(4)) {
        v.push(0)
      }
      PixelSearch &fx, &fy, v[1], v[2], v[1], v[2], v[3], v[4]
      if (fx != "") {
        correct.Push(v)
      }
    }
    tip "correct: " correct.Length ",timeout:" timeout
    if (appear_times >= 0) {
      ; 可运行直到确认出现须积累的次数,0和1效果一样，都找到就退出
      if (correct.Length >= arr.length - correct_offset) {
        num++
        if (num >= appear_times) {
          if tool_debug
            ToolTip "", 0, 0, 2
          return correct
        }
      } else {
        num := 0
      }
    } else {
      ; 可运行直到确认消失须积累的次数
      if (correct.Length < arr.length - correct_offset) {
        num--
        if (num <= appear_times) {
          if tool_debug
            ToolTip "", 0, 0, 2
          return correct
        }
      } else {
        num := 0
      }
    }
    fn() ;可以为""不会报错
    sleep interval
    if (timeout > 0 && A_TickCount - StartTime > timeout) {
      if tool_debug
        ToolTip "", 0, 0, 2
      return "timeout"
    }
  }
}
mwaitfunc(arr, note, appear_times := 1, fn := fn := () => {}, interval := 100, timeout := 0) {
  ; 因为arr是一组闭包函数，ahk无法打印其内容，用note告知其作用
  StartTime := A_TickCount
  if tool_debug
    ToolTip "mwaitfunc:" note, 0, 0, 2
  global debug_json := "mwaitfunc:" note
  ; 传入二维数组arr,[[判断函数，执行函数],...]
  reset_arr := zeros(arr.Length)
  count_arr := reset_arr
  loop {
    for k, v in arr {
      if (v[1]()) {
        if (count_arr[k] == 0) {
          count_arr := reset_arr
          count_arr[k] := count_arr[k] + 1
        } else {
          count_arr[k] := count_arr[k] + 1
        }
        if (count_arr[k] >= appear_times) {
          tip note ": " k
          if (v.Has(2)) {
            v[2]()
          }
          if tool_debug
            ToolTip "", 0, 0, 2
          return k
        }
      }
    }
    fn() ;可以为""不会报错
    sleep interval
    if (timeout > 0 && A_TickCount - StartTime > timeout) {
      if tool_debug
        ToolTip "", 0, 0, 2
      return "timeout"
    }
  }
}
getpix(x, y, color, similar := 6) {
  ; 默认能接受一定误差
  PixelSearch &fx, &fy, x, y, x, y, color, similar
  if (fx != "") {
    ; return [x,y,color]
    return true
  } else {
    return
  }
}
mgetpix(arr) {
  ; arr:=[[1317, 226, 0x3C3A44,6], [1381, 224, 0x313B49,6]]
  ; arr:=[[1320,884,0x222022,6], [2344,888,0x672337,6]]
  find := []
  for k, v in arr {
    if (!v.Has(4)) {
      v.push(6) ; 默认能接受一定误差
    }
    PixelSearch &fx, &fy, v[1], v[2], v[1], v[2], v[3], v[4]
    if (fx != "") {
      find.push(v)
    }
  }
  ; tip find
  if (find.length == arr.length) {
    return find
  } else {
    return 0
  }
}


arr_in(arr, val) {
  for v in arr {
    if (v == val) {
      return true
    }
  }
}
arr_del(arr, val) {
  for i, v in arr {
    if (v == val) {
      arr.RemoveAt(i)
      return true
    }
  }
}
zeros(num) {
  zeroArray := []
  loop num {
    zeroArray.Push(0)
  }
  return zeroArray
}
sendstd(key, delay := 160, keeppress := 40) {
  if (is_arr(key)) {
    ; 例子：sendstd(["RButton","LButton","Space"],50,30)
    key_unup := []
    stddelay := keeppress
    for k, v in key {
      if (IsNumber(v) and v > 9) { ;10以内的数字作为按键，而不是延迟，所以延迟最小为10
        sleep v
        stddelay := 0
      } else {
        if (arr_in(key_unup, v)) {
          arr_del(key_unup, v)
          send "{" v " Up}"
          sleep stddelay
          stddelay := keeppress
        } else {
          key_unup.Push(v)
          send "{" v " Down}"
          sleep stddelay
          stddelay := delay
        }
      }
    }
    for v in key_unup {
      sleep 10
      send "{" v " Up}"
    }
  } else {
    send "{" key " Down}"
    sleep keeppress
    send "{" key " Up}"
    sleep delay
  }
}
is_arr(var) {
  return IsObject(var) && var.HasProp("Length")
}
msgbox_autoclose(msg, delay := 1000) {
  SetTimer(() => WinClose("ahk_class #32770"), -delay)
  MsgBox msg
}
global new_tips := 0
tip(message, delay := 3000, id := 1) {
  global new_tips += 1
  if (IsObject(message)) {
    message := obj2json(message)
  }
  message := format_json(message)
  ToolTip message, , , id
  fn() {
    global new_tips -= 1
    if (new_tips <= 0) {
      ToolTip(, , , id)
    }
  }
  SetTimer fn, -delay
}
RepeatString(str, count) {
  repeatedStr := ""
  Loop count {
    repeatedStr .= str
  }
  return repeatedStr
}
; 生成标准紧凑的 JSON 字符串
obj2json(obj) {
  if !IsObject(obj) {
    return obj  ; 如果不是对象，直接返回
  }
  json := ""
  if (obj is Array) {
    json := "["
    for value in obj {
      json .= obj2json(value) ","
    }
    json := RegExReplace(json, ",$", "")
    json .= "]"
  } else if (obj is Map) {
    json := "{"
    for key, value in obj {
      ; Map的key可能不是字符串，需要转换
      keyStr := Type(key) = "String" ? '"' key '"' : obj2json(key)
      json .= keyStr ':' obj2json(value) ","
    }
    json := RegExReplace(json, ",$", "")
    json .= "}"
  } else {
    json := "{"
    for key, value in obj.OwnProps() {
      json .= '"' key '":' obj2json(value) ","
    }
    json := RegExReplace(json, ",$", "")
    json .= "}"
  }
  return json
}

; 函数：将紧凑的 JSON 字符串转换为带换行和缩进的格式
format_json(json, indent_str := "    ") {
  if (IsObject(json))
    json := obj2json(json)
  ; 如果JSON字符串为空，直接返回
  ; 如果首字符不是[或{，说明不是JSON字符串，直接返回
  if !RegExMatch(json, "^[[{]")
    return json
  else if json == "{}"
    return "{}"
  else if json == "[]"
    return "[]"
  formatted_json := ""
  indent := 0
  in_string := false
  Loop Parse, json
  {
    char := A_LoopField
    if (char = '"') {
      in_string := !in_string
    }
    if (!in_string) {
      if (char = '{' || char = '[') {
        indent += 1
        formatted_json .= char "`n" RepeatString(indent_str, indent)
        continue
      } else if (char = '}' || char = ']') {
        indent -= 1
        formatted_json := RTrim(formatted_json) "`n" RepeatString(indent_str, indent)
        formatted_json .= char
        continue
      } else if (char = ',') {
        formatted_json .= char "`n" RepeatString(indent_str, indent)
        continue
      } else if (char = ':') {
        formatted_json .= char " "
        continue
      }
    }
    formatted_json .= char
  }
  return formatted_json
}
; 示例对象tool_json
tool_json := {
  name: "John",
  age: 30,
  address: {
    city: "New York",
    street: "5th Ave",
    details: {
      zip: "10001",
      state: "NY"
    }
  },
  phones: ["123-4567", "987-6543"],
  preferences: {
    contact: "email",
    language: "English",
    notifications: {
      email: true,
      sms: false,
      color: [
        "red",
        "green",
        "blue"
      ]
    }
  }
}