-- USE IT ONLY IF YOU WANT TO BE SUSSY!!!

function blammedLights(direction)
    event = 'Blammed Lights'
    if direction == 0 then
        triggerEvent(event, '3', '')
    elseif direction == 1 then
        triggerEvent(event, '1', '')
    elseif direction == 2 then
        triggerEvent(event, '2', '')
    elseif direction == 3 then
        triggerEvent(event, '4', '')
    else
        triggerEvent(event, '0', '')
    end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if not isSustainNote then
	    blammedLights(direction)
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if not isSustainNote then
	    blammedLights(direction)
    end
end