#include "_GetUTCMinutes.au3"
#include <MsgBoxConstants.au3>

Local $min = 0
While 1
    While 1
        If MsgBox($MB_YESNO + $MB_ICONQUESTION, "_GetUTCMinutes_Test", "Get minutes until server reset?") = $IDYES Then
            $min = _GetUTCMinutes(10, 1, True, True)
            If $min >= 0 Then
                ExitLoop
            EndIf
        Else
            Exit
        EndIf
        MsgBox($MB_ICONWARNING, "_GetUTCMinutes_Test", "Failed to get minutes until server reset!")
    WEnd
    MsgBox($MB_OK, "_GetUTCMinutes_Test", $_GetUTCMinutes_LastTimeServer & @CRLF & $min)
WEnd