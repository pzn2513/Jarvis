zeros(num) {
    zeroArray := []
    loop num {
        zeroArray.Push(0)
    }
    return zeroArray
}
sendstd(key,delay:=150,keeppress:=30){
    send "{" key " Down}"
    sleep keeppress
    send "{" key " Up}"
    sleep delay
}
printarr_2d(arr:=[["hello","world"],["this is printarr_2d","default"]]){
    if(!is_arr(arr)){
        msgbox_autoclose "is not array"
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
    msgbox_autoclose output
}
is_arr(var) {
    return IsObject(var) && var.HasProp("Length")
}

msgbox_autoclose(msg,delay:=1000){
    SetTimer(() => WinClose("ahk_class #32770"), -delay)
    MsgBox msg
}
tip(message,delay:=3000){
    ToolTip message
    SetTimer ()=>ToolTip(),-delay
}