#include-once

Func LoadLocalizationDefaults()
    If GetValue("Language") = "Russian" Then
        SetDefault("InvokeKey", "{CTRLDOWN}i{CTRLUP}")
        SetDefault("JumpKey", "{SPACE}")
        SetDefault("GameMenuKey", "{ESC}")
        SetDefault("CursorModeKey", "{F2}")
        SetDefault("InventoryKey", "i")
        SetDefault("VIPAccountRewardButtonLeftOffset", 13)
        SetDefault("VIPAccountRewardButtonTopOffset", 1)
        SetDefault("VIPAccountRewardButtonRightOffset", 50)
        SetDefault("VIPAccountRewardButtonBottomOffset", 10)
        SetDefault("InputBoxWidth", -1)
        SetDefault("InputBoxHeight", 155)
        SetDefault("StartInputBoxWidth", 300)
        SetDefault("StartInputBoxHeight", -1)
        SetDefault("SplashWidth", 380)
        SetDefault("SplashHeight", 185)
        SetDefault("ScreenDetectionSplashWidth", 380)
        SetDefault("ScreenDetectionSplashHeight", 400)
        SetDefault("LogInServerAddress", "208.95.186.167, 208.95.186.168, 208.95.186.96")
    Else
        SetDefault("InvokeKey", "{CTRLDOWN}i{CTRLUP}")
        SetDefault("JumpKey", "{SPACE}")
        SetDefault("GameMenuKey", "{ESC}")
        SetDefault("CursorModeKey", "{ALT}")
        SetDefault("InventoryKey", "i")
        SetDefault("VIPAccountRewardButtonLeftOffset", 13)
        SetDefault("VIPAccountRewardButtonTopOffset", 1)
        SetDefault("VIPAccountRewardButtonRightOffset", 50)
        SetDefault("VIPAccountRewardButtonBottomOffset", 10)
        SetDefault("InputBoxWidth", -1)
        SetDefault("InputBoxHeight", 145)
        SetDefault("StartInputBoxWidth", 300)
        SetDefault("StartInputBoxHeight", -1)
        SetDefault("SplashWidth", 380)
        SetDefault("SplashHeight", 185)
        SetDefault("ScreenDetectionSplashWidth", 380)
        SetDefault("ScreenDetectionSplashHeight", 400)
        SetDefault("LogInServerAddress", "208.95.186.167, 208.95.186.168, 208.95.186.96")
    EndIf
EndFunc

#include <GUIConstants.au3>
#include <GUIConstantsEx.au3>
#include <ButtonConstants.au3>
#include <WinAPIFiles.au3>

Func GetLanguage($default = "English", $file = @ScriptDir & "\Localization.ini")
    Local $langlist = $default
    Local $sections = IniReadSectionNames($file)
    If @error = 0 Then
        For $i = 1 To $sections[0]
            If $sections[$i] <> $default Then $langlist &= "|" & $sections[$i]
        Next
    EndIf
    Local $hGUI = GUICreate("Language", 200, 85)
    Local $hCombo = GUICtrlCreateCombo("", 25, 15, 150, -1)
    GUICtrlSetData(-1, $langlist, $default)
    Local $hButton = GUICtrlCreateButton("OK", 58, 50, 84, -1, $BS_DEFPUSHBUTTON)
    GUISetState()
    While 1
        Switch GUIGetMsg()
            Case $GUI_EVENT_CLOSE
                Exit
            Case $hButton
                Local $sCurrCombo = GUICtrlRead($hCombo)
                For $i = 1 To $sections[0]
                    If $sections[$i] == $sCurrCombo Then
                        GUIDelete()
                        Return $sCurrCombo
                    EndIf
                Next
        EndSwitch
    WEnd
EndFunc

Func LoadLocalizations($lang = 0, $file = 0, $iniwrite = 1)
    Local $l = $lang, $f = $file
    If Not $f Then $f = @ScriptDir & "\Localization.ini"
    If Not $l Or ( IsNumber($l) And $l = 1 ) Then
        Local $s = @AppDataCommonDir & "\Neverwinter Invoke Bot"
        $l = IniRead($s & "\Settings.ini", "AllAccounts", "Language", "")
        If $l = "" Or $lang Then
            If $l = "" Then $l = "English"
            $l = GetLanguage($l, $f)
            If $iniwrite Then
                DirCreate($s)
                IniWrite($s & "\Settings.ini", "AllAccounts", "Language", $l)
            EndIf
        EndIf
    EndIf
    Local $values = IniReadSection($f, $l)
    If @error = 0 Then
        For $i = 1 To $values[0][0]
            Local $v = BinaryToString(StringToBinary($values[$i][1]), 4)
            If $v = "" Then $v = BinaryToString(StringToBinary(IniRead($f, "English", $values[$i][0], "")), 4)
            If Not IsDeclared("LOCALIZATION_" & $values[$i][0]) Then Assign("LOCALIZATION_" & $values[$i][0], StringReplace($v, "<BR>", @CRLF), 2)
        Next
    EndIf
    If $l <> "English" Then LoadLocalizations("English", $f)
    Return $l
EndFunc

Func Localize($s, $f1=0, $r1=0, $f2=0, $r2=0, $f3=0, $r3=0, $f4=0, $r4=0, $f5=0, $r5=0, $f6=0, $r6=0, $f7=0, $r7=0, $f8=0, $r8=0, $f9=0, $r9=0, $f10=0, $r10=0)
    #forceref $f1, $f2, $f3, $f4, $f5, $f6, $f7, $f8, $f9, $f10
    #forceref $r1, $r2, $r3, $r4, $r5, $r6, $r7, $r8, $r9, $r10
    Local $v = $s
    If IsDeclared("LOCALIZATION_" & $v) Then $v = Eval("LOCALIZATION_" & $v)
    For $i = 1 To Int((@NumParams - 1) / 2)
        $v = StringReplace($v, Eval("f" & $i), Eval("r" & $i))
    Next
    Return $v
EndFunc

