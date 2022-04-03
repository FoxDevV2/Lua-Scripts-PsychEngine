function onUpdatePost(el)
    if not inGameOver then
    setProperty('timeBar.color', getColorFromHex('1CFF00'))
    setProperty('timeBarBG.color', getColorFromHex('00000'))
    setProperty('timeBarBG.alpha', 1)
    setProperty('timeBar.alpha', 1)
    setProperty('timeBar.x', 180)
    setProperty('timeBarBG.x', 180)
    setProperty('timeTxt.visible', false)
	makeLuaText('funnikade', getPropertyFromClass('PlayState', 'SONG.song') .. ' ' .. getProperty('') .. '',getProperty('healthBarBG.width'),200 ,20)
	addLuaText('funnikade')
setTextSize('funnikade', 30)
end
end
