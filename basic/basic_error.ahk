OnError error_log
; mode值为"return"的报错（小报错），可继续执行，记录下来以供优化
error_log(exception, mode) {
    currentTime := FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss")
    FileAppend currentTime " on line " exception.Line ": " exception.Message "`n", "errorlog.txt"
    ; tip mode
    return -1
}