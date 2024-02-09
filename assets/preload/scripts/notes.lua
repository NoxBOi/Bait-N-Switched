local xenoTrigger = false
function onCreatePost()
    if dadName == 'virgincorrupt-xeno' then
        if not middlescroll then
            setPropertyFromGroup('playerStrums', 0, 'x', defaultOpponentStrumX0)
            setPropertyFromGroup('playerStrums', 1, 'x', defaultOpponentStrumX1)
            setPropertyFromGroup('playerStrums', 2, 'x', defaultOpponentStrumX2)
            setPropertyFromGroup('playerStrums', 3, 'x', defaultOpponentStrumX3)
            setPropertyFromGroup('opponentStrums', 0, 'x', defaultPlayerStrumX0)
            setPropertyFromGroup('opponentStrums', 1, 'x', defaultPlayerStrumX1)
            setPropertyFromGroup('opponentStrums', 2, 'x', defaultPlayerStrumX2)
            setPropertyFromGroup('opponentStrums', 3, 'x', defaultPlayerStrumX3)
        end
        xenoTrigger = true
    end

    if getProperty('inmalicmode') == true then
        if not middlescroll then
            setPropertyFromGroup('playerStrums', 0, 'x', defaultPlayerStrumX0-65)
            setPropertyFromGroup('playerStrums', 1, 'x', defaultPlayerStrumX1-65)
            setPropertyFromGroup('playerStrums', 2, 'x', defaultPlayerStrumX2-65)
            setPropertyFromGroup('playerStrums', 3, 'x', defaultPlayerStrumX3-65)
            setPropertyFromGroup('opponentStrums', 0, 'x', defaultOpponentStrumX0+75)
            setPropertyFromGroup('opponentStrums', 1, 'x', defaultOpponentStrumX1+75)
            setPropertyFromGroup('opponentStrums', 2, 'x', defaultOpponentStrumX2+75)
            setPropertyFromGroup('opponentStrums', 3, 'x', defaultOpponentStrumX3+75)
        else
            setPropertyFromGroup('opponentStrums', 0, 'x', defaultOpponentStrumX0+100)
            setPropertyFromGroup('opponentStrums', 1, 'x', defaultOpponentStrumX1+100)
            setPropertyFromGroup('opponentStrums', 2, 'x', defaultOpponentStrumX2-100)
            setPropertyFromGroup('opponentStrums', 3, 'x', defaultOpponentStrumX3-100)
        end

        addLuaScript('scripts/malic/Tilting')
    end
end


function onUpdatePost()
    if xenoTrigger == true then
        P1Mult = getProperty('healthBar.x') + ((getProperty('healthBar.width') * getProperty('healthBar.percent') * 0.01) + (150 * getProperty('iconP1.scale.x') - 150) / 2 - 26)

        P2Mult = getProperty('healthBar.x') + ((getProperty('healthBar.width') * getProperty('healthBar.percent') * 0.01) - (150 * getProperty('iconP2.scale.x')) / 2 - 26 * 2)
    
        setProperty('iconP1.x',P1Mult - 90)
    
        setProperty('iconP1.origin.x',240)
    
        setProperty('iconP1.flipX',true)
    
        setProperty('iconP2.x',P2Mult + 100)
    
        setProperty('iconP2.origin.x',-100)
    
        setProperty('iconP2.flipX',true)
    
        setProperty('healthBar.flipX',true)
    end
end