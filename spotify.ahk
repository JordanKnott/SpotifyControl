#SingleInstance Force

SoundState := 1

+!o::
WinGetTitle, Title, A
Gosub, ActivateSpot
if(SoundState = 1)
{
    Loop, 20
    {
        Send ^{Down}
        Sleep, 20
    }
    SoundState := 0
    WinActivate, %Title%
    Return
}
if(SoundState = 0)
{
    Loop, 20
    {
        Send ^{Up}
        Sleep, 10
    }
    SoundState := 1
    WinActivate, %Title%
    Return
}
Return

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
if(SongTitle = "Spotify"){
    TrayTip, Current Spotify Song, Paused
    Return
}
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
