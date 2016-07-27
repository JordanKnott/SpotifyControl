#SingleInstance Force

SoundState := 1
PausedState := 0

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
        TrayTip, Spotify, Muted
        SoundState := 0
    } else if(SoundState = 0) {
        Loop, 20
        {
            Send ^{Up}
            Sleep, 10
        }
        TrayTip, Spotify, Unmuted
        SoundState := 1
    }
    WinActivate, %Title%
    Return

+!p::
    WinGetTitle, Title, A
    Gosub, ActivateSpot
    Send {Space}
    if(PausedState = 1){
        TrayTip, Spotify, Unpaused
        PausedState := 0
    }else {
        TrayTip, Spotify, Paused
        PausedState := 1
    }
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

MinimizeSpot:
    Spot := GetSpotWindow()
    WinMinimize, %Spot%
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
