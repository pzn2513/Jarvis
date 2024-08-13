/*
一些工具函数
*/
tool_debug:=true
debug_json:=""
waitpix(x,y,color,similar:=0,appear_times:=1,fn:=()=>{},interval:=100,timeout:=0){
    StartTime := A_TickCount
    if tool_debug
        ToolTip "waitpix " x "," y,0,0,2
        global debug_json:="waitpix: " x "," y "," color "," similar "," appear_times
    num:=0
    loop{
        PixelSearch &fx, &fy, x, y, x, y, color, similar
        if(appear_times>=0){
            ; 可运行直到确认出现须积累的次数,0和1效果一样，都找到就退出
            if(fx!=""){
                num++
                if(num>=appear_times){
                    if tool_debug
                        ToolTip "",0,0,2
                    return [x,y,color]
                }
            }else{
                num:=0
            }
        }else{
            ; 可运行直到确认消失须积累的次数
            if(fx==""){
                num--
                if(num<=appear_times){
                    if tool_debug
                        ToolTip "",0,0,2
                    return [x,y,color]
                }
            }else{
                num:=0
            }
        }
        fn()
        sleep interval
        if(timeout>0 && A_TickCount-StartTime>timeout){
            if tool_debug
                ToolTip "",0,0,2
            return "timeout"
        }
    }
}
; waitpix如果容易误判的，就用mwaitpix加多几个pix增强可信度
mwaitpix(arr,correct_offset:=0,appear_times:=1,fn:=()=>{},interval:=100,timeout:=0){
    StartTime := A_TickCount
    if tool_debug
        ToolTip "mwaitpix " arr[1][1] "," arr[1][2],0,0,2
        global debug_json:="mwaitpix: " obj2json(arr)
    ; arr:=[[x,y,color,similar],...] 
    num:=0
    loop{
        correct:=[]
        for k,v in arr{
            if(!v.Has(4)){
                v.push(0)
            }
            PixelSearch &fx, &fy, v[1], v[2], v[1], v[2], v[3], v[4]
            if(fx!=""){
                correct.Push(v)
            }
        }
        tip "correct: " correct.Length ",timeout:" timeout
        if(appear_times>=0){
            ; 可运行直到确认出现须积累的次数,0和1效果一样，都找到就退出
            if(correct.Length>=arr.length-correct_offset){
                num++
                if(num>=appear_times){
                    if tool_debug
                        ToolTip "",0,0,2
                    return correct
                }
            }else{
                num:=0
            }
        }else{
            ; 可运行直到确认消失须积累的次数
            if(correct.Length<arr.length-correct_offset){
                num--
                if(num<=appear_times){
                    if tool_debug
                        ToolTip "",0,0,2
                    return correct
                }
            }else{
                num:=0
            }
        }
        fn() ;可以为""不会报错
        sleep interval
        if(timeout>0 && A_TickCount-StartTime>timeout){
            if tool_debug
                ToolTip "",0,0,2
            return "timeout"
        }
    }
}
mwaitfunc(arr,note,appear_times:=1,fn:=fn:=()=>{},interval:=100,timeout:=0){
    ; 因为arr是一组闭包函数，ahk无法打印其内容，用note告知其作用
    StartTime := A_TickCount
    if tool_debug
        ToolTip "mwaitfunc:" note,0,0,2
        global debug_json:="mwaitfunc:" note
    ; 传入二维数组arr,[[判断函数，执行函数],...]
    reset_arr:=zeros(arr.Length)
    count_arr:=reset_arr
    loop{
        for k,v in arr{
            if(v[1]()){
                if(count_arr[k]==0){
                    count_arr:=reset_arr
                    count_arr[k]:=count_arr[k]+1
                }else{
                    count_arr[k]:=count_arr[k]+1
                }
                if(count_arr[k]>=appear_times){
                    tip note ": " k
                    if(v.Has(2)){
                        v[2]() 
                    }
                    if tool_debug
                        ToolTip "",0,0,2
                    return k
                }
            }
        }
        fn() ;可以为""不会报错
        sleep interval
        if(timeout>0 && A_TickCount-StartTime>timeout){
            if tool_debug
                ToolTip "",0,0,2
            return "timeout"
        }
    }
}
getpix(x,y,color,similar:=0){
    PixelSearch &fx, &fy, x, y, x, y, color, similar
    if(fx!=""){
        ; return [x,y,color]
        return true
    }else{
        return
    }
}
mgetpix(arr){
    ; arr:=[[1317, 226, 0x3C3A44,6], [1381, 224, 0x313B49,6]]
    ; arr:=[[1320,884,0x222022,6], [2344,888,0x672337,6]]
    find:=[]
    for k,v in arr{
        if(!v.Has(4)){
            v.push(0)
        }
        PixelSearch &fx, &fy, v[1], v[2], v[1], v[2], v[3], v[4]
        if(fx!=""){
            find.push(v)
        }
    }
    tip find
    if(find.length==arr.length){
        return find
    }else{
        return
    }
}


arr_in(arr,val){
    for v in arr{
        if(v==val){
            return true
        }
    }
}
arr_del(arr,val){
    for i,v in arr{
        if(v==val){
            arr.RemoveAt(i)
            printarr_2d(arr)
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
sendstd(key,delay:=150,keeppress:=30){
    if(is_arr(key)){
        key_unup:=[]
        stddelay:=keeppress
        for k,v in key{
            if(IsNumber(v) and v>9){ ;10以内的数字作为按键，而不是延迟，所以延迟最小为10
                sleep v
                stddelay:=0
            }else{
                
                if(arr_in(key_unup,v)){
                    arr_del(key_unup,v)
                    send "{" v " Up}"
                    sleep stddelay
                    stddelay:=keeppress
                }else{
                    key_unup.Push(v)
                    send "{" v " Down}"
                    sleep stddelay
                    stddelay:=delay
                }
            }
        }
        for v in key_unup{
            sleep 10
            send "{" v " Up}"
        }
    }else{
        send "{" key " Down}"
        sleep keeppress
        send "{" key " Up}"
        sleep delay        
    }
}
printarr_2d(arr:=[["hello","world"],["this is printarr_2d","default"]]){
    if(!is_arr(arr)){
        tip "is not array"
        return
    }
    output:= ""
    for k,v in arr{
        if(is_arr(v)){
            for k1,v1 in v{
                output .= v1 ","
            }
            output .= "`n"            
        }else{
            output .= v ","
        }
    }
    tip output
}
is_arr(var) {
    return IsObject(var) && var.HasProp("Length")
}
msgbox_autoclose(msg,delay:=1000){
    SetTimer(() => WinClose("ahk_class #32770"), -delay)
    MsgBox msg
}
tip(message,delay:=3000,id:=1){
    message:=obj2json(message)
    message:=format_json(message)
    ToolTip message,,,id
    SetTimer ()=>ToolTip(,,,id),-delay
}
RepeatString(str, count) {
    repeatedStr := ""
    Loop count {
        repeatedStr .= str
    }
    return repeatedStr
}
; 生成标准紧凑的 JSON 字符串
obj2json(obj){
    if !IsObject(obj) {
        if IsNumber(obj) {
            return obj  ; 如果是数字，直接返回
        } else {
            return '"' obj '"'  ; 如果是字符串，返回加引号的字符串
        }
    }

    json := ""
    if obj is Array {
        json := "["
        for value in obj {
            json .= obj2json(value) ","
        }
        json := RegExReplace(json, ",$", "")
        json .= "]"
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
    if json=="{}"
        return "{}"
    if json=="[]"
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
            color:[
                "red",
                "green",
                "blue"
            ]
        }
    }
}