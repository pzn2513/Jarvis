help星铁(){
    A_CoordModeToolTip:="Screen"
    A_CoordModePixel:="Screen"
    A_CoordModeMouse:="Screen"
    loop{
        ; 5137,567,0xFFFFFF
        ; 5137,641,0xFFFFFF
        ; 5137,715,0xFFFFFF
        ToolTip "help星铁",1920*2,0,20
        ; if(mgetpix([[5137,790,0xFFFFFF],[5129,802,0x5E6670,20]])){
        ;     ; 对话选项
        ;     ; block_click(5210,577)
        ;     ; block_click(5210,651)
        ;     ; block_click(5210,725)
        ;     block_click(5210,800)
        ; }else if(mgetpix([[4774,966,0xAE8708],[4798,1004,0x110600]])){
        ;     ; 点击后继续
        ;     block_click(4804,599)
        ; }
        ; sleep 1000
    }     
}