#SingleInstance Force

+!p::
WinGetTitle, Title, A
Gosub, ActivateSpot
Send {Space}
WinActivate, %Title%
Return

+!n::
WinGetTitle, Title, A
Gosub, ActivateSpot
Send ^{Right}
WinActivate, %Title%
Return

+!t::
SongTitle := GetSpotWindow()
TrayTip, Current Spotify Song, %SongTitle%
Return

ActivateSpot:
Spot := GetSpotWindow()
WinActivate, %Spot%
Return

GetSpotWindow()
{
    WinGet, WindowList, List
    Loop %WindowList%
    {
        WinUID := WindowList%A_Index%
        WinGetTitle, WinTitle, ahk_id %WinUID%
        WinGet, WinProcName, ProcessName, ahk_id %WinUID%
        If WinProcName = Spotify.exe
        Break
    }
    Return %WinTitle%
}
