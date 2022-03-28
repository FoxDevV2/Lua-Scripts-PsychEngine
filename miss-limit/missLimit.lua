--easy configs--
missLimit = 10 --this is the miss limit, if you put the value 0 you will die instantly, so dont put 0
cantDie = false --if the value is true you can only die by the miss limit
showHealthBar = true --if the value is false the health bar will not be shown
textSize = 30 --da text size


--da code--
function onCreate()
	makeLuaText('limitText', 'Miss limit:', 300, 20, 670)
	setTextAlignment('limitText', 'left')
	setObjectCamera('limitText', 'hud')
	setTextSize('limitText', textSize)
	setProperty('limitText.alpha', 0)
	addLuaText('limitText')

	makeLuaText('limit', missLimit, 300, 230, 670)
	setTextAlignment('limit', 'left')
	setObjectCamera('limit', 'hud')
	setTextSize('limit', textSize)
	setProperty('limit.alpha', 0)
	addLuaText('limit')
end

function onUpdate()
	if misses >= missLimit then
		setProperty('health', 0)
	end
	if cantDie == true then
    	if getProperty('health') <= 0.1 then
      	  setProperty('health', 0.025)
    	end
	end
	if showHealthBar == false then
		setProperty('healthBarBG.visible', false)
		setProperty('healthBar.visible', false)
		setProperty('iconP1.visible', false)
		setProperty('iconP2.visible', false)
	end
end

function onSongStart()
	doTweenAlpha('limitTextTween', 'limitText', 1, 0.5, linear)
	doTweenAlpha('limitTween', 'limit', 1, 0.3, linear)
end
