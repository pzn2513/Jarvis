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
tip(message,delay:=3000){
    ToolTip message
    SetTimer ()=>ToolTip(),-delay
}