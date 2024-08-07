#HotIf WinActive("绝区零 ahk_class UnityWndClass")
~^Numpad0::零号业绩循环()
~^Numpad1::拿命验收循环()
~^0::拿命验收循环()
~^Numpad2::零号刷特殊区域()
~AppsKey & Numpad0::t0()
~AppsKey & Numpad1::t1()
; #Numpad0::ttt()
#HotIf
#Include 零号业绩.ahk
#Include 拿命验收.ahk

t0(){
    res:=mwaitpix([[1084,311,0x6C54A1,16],[1222,307,0x775FB4,16]],0,1,,100,2000)
    ; res:=mwaitpix([[1084,311,0x6C54A1,16],[1222,307,0x775FB4,16]])
    ; tip "零号业绩"
    ; if(res=="timeout"){
    ;     global 零号业绩已达上限:=true
    ;     tip "零号业绩已达上限"
    ; }else{
    ;     mwaitpix [[1084,311,0x6C54A1,16],[1222,307,0x775FB4,16]],0,-1,()=>click(1157,319) ;业绩
    ; }
}
t1(){
    arr:=[
        [1278,458,0xFAAB2A],
        [1383,569,0xA71700],
        [1376,680,0xD9D8D9],
    ]
    mwaitpix(arr)
    mwaitpix(arr,0,-15,()=>Click(1409,672))
}
; ttt(){
;     InstallKeybdHook
;     InstallMouseHook
;     KeyHistory
; }