--this script is meant for another mod the team is making but im tossing here to keep the autenticity
local tiltLeft = true
local tiltRight = false
local camIntensity = 2
function onEvent(name,value1,value2)
    if name == 'Add Camera Zoom' then
        if tiltLeft then
            setProperty('camHUD.angle', camIntensity - camIntensity - camIntensity)
            doTweenAngle('camHUDLTC', 'camHUD', 0,0.2,'circOut')
            tiltLeft = false
            tiltRight = true
        elseif tiltRight then
            setProperty('camHUD.angle', camIntensity)
            doTweenAngle('camHUDLTC', 'camHUD', 0,0.2,'circOut')
            tiltLeft = true
            tiltRight = false
        end
    end
end

local noteuhyeah = 15
function onCreate()
    if downscroll then
        noteuhyeah = -15
    end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
    if getPropertyFromClass('ClientPrefs', 'noteShenanigans') == true then
        if noteData == 0 then
            setPropertyFromGroup('playerStrums', 0, 'y', defaultPlayerStrumY0 - noteuhyeah)
            noteTweenY('player1', 4, defaultPlayerStrumY0,0.2,'sine')
        end
        if noteData == 1 then
            setPropertyFromGroup('playerStrums', 1, 'y', defaultPlayerStrumY0 - noteuhyeah)
            noteTweenY('player2', 5, defaultPlayerStrumY0,0.2,'sine')
        end
        if noteData == 2 then
            setPropertyFromGroup('playerStrums', 2, 'y', defaultPlayerStrumY0 - noteuhyeah)
            noteTweenY('player3', 6, defaultPlayerStrumY0,0.2,'sine')
        end
        if noteData == 3 then
            setPropertyFromGroup('playerStrums', 3, 'y', defaultPlayerStrumY0 - noteuhyeah)
            noteTweenY('player4', 7, defaultPlayerStrumY0,0.2,'sine')
        end
    end
end

function opponentNoteHit(id, noteData, noteType, isSustainNote)
    if getPropertyFromClass('ClientPrefs', 'noteShenanigans') == true then
        if noteData == 0 then
            setPropertyFromGroup('opponentStrums', 0, 'y', defaultOpponentStrumY0 - noteuhyeah)
            noteTweenY('opp1', 0, defaultOpponentStrumY0,0.2,'sine')
        end
        if noteData == 1 then
            setPropertyFromGroup('opponentStrums', 1, 'y', defaultOpponentStrumY0 - noteuhyeah)
            noteTweenY('opp2', 1, defaultOpponentStrumY0,0.2,'sine')
        end
        if noteData == 2 then
            setPropertyFromGroup('opponentStrums', 2, 'y', defaultOpponentStrumY0 - noteuhyeah)
            noteTweenY('opp3', 2, defaultOpponentStrumY0,0.2,'sine')
        end
        if noteData == 3 then
            setPropertyFromGroup('opponentStrums', 3, 'y', defaultOpponentStrumY0 - noteuhyeah)
            noteTweenY('opp4', 3, defaultOpponentStrumY0,0.2,'sine')
        end
    end
end