local infoType = 0;
local diffT = ''

function addText(tag, x, y, text, size, alignment, width, font, color, borderSize, camera, borderColor, italic)
	alignment = alignment or 'left';
	width = width or 0;
	font = font or '';
	color = color or 'FFFFFF';
	borderSize = borderSize or 0;
	borderColor = borderColor or '000000';
	italic = italic or false;

	makeLuaText(tag, text, width, x, y);
	setTextSize(tag, size);
	setTextAlignment(tag, alignment);
	setTextBorder(tag, borderSize, borderColor);
	setTextColor(tag, color);
	setTextItalic(tag, italic);
	setObjectCamera(tag, camera)

	if font ~= '' then
		setTextFont(tag, font);
	end

	addLuaText(tag);
end

function addGraphic(tag, x, y, width, height, color, alpha)
	makeLuaSprite(tag, '', x, y)
	makeGraphic(tag, width, height, color)
	setObjectCamera(tag, 'other')
	setProperty(tag..'.alpha', alpha)
    addLuaSprite(tag)
end

function onCreatePost()
	local opLength = string.len(dadName) + 10
	local bfLength = string.len(boyfriendName) + 8
	local snLength = string.len(songName) + 6
	if opLength > snLength then
		if bfLength > opLength then
			diffT = 'bf'
		else
			diffT = 'op'
		end
	else
		diffT = 'sn'
	end

	debugPrint(string.len(boyfriendName) + 8)
	debugPrint(diffT)

	if diffT == 'op' then
		addGraphic('debugBG', 0, (screenHeight / 2) - 190, 300 + ((string.len(dadName) - 8) * 11), 340, '000000', 0.68)
	end
	if diffT == 'bf' then
		addGraphic('debugBG', 0, (screenHeight / 2) - 190, 300 + ((string.len(boyfriendName) - 8) * 11), 340, '000000', 0.68)
	end
	if diffT == 'sn' then
		addGraphic('debugBG', 0, (screenHeight / 2) - 190, 300 + ((string.len(songName) - 11) * 11), 340, '000000', 0.68)
	end
	addText('debugInfo', 10, 0, '', 24, 'left', 0, '', 'FFFFFF', 2, 'other');
	screenCenter('debugInfo', 'y')
end

function onUpdatePost(elapsed)
	if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.TAB') then
		infoType = infoType + 1
		if infoType == 4 then
			infoType = 0
		end
	end

	songSpeed = getProperty('songSpeed');

	if infoType == 0 then
		setTextString('debugInfo', '')
		setProperty('debugBG.scale.y', 0)
	end
	if infoType == 1 then
		setTextString('debugInfo', 'Song: ' .. songName .. '\nBPM: ' .. curBpm .. '\nLength: ' .. milliToHuman(math.floor(songLength)) .. '\nScroll Speed: ' .. round(songSpeed, 2) .. '\n')
		setProperty('debugBG.scale.y', 0.35)
	end
	if infoType == 2 then
		setTextString('debugInfo', 'Song: ' .. songName .. '\nBPM: ' .. curBpm .. '\nLength: ' .. milliToHuman(math.floor(songLength)) .. '\nScroll Speed: ' .. round(songSpeed, 2) .. '\n\ncurBeat: ' .. curBeat .. '\ncurStep: ' .. curStep .. '\n')
		setProperty('debugBG.scale.y', 0.535)
	end
	if infoType == 3 then
		setTextString('debugInfo', 'Song: ' .. songName .. '\nBPM: ' .. curBpm .. '\nLength: ' .. milliToHuman(math.floor(songLength)) .. '\nScroll Speed: ' .. round(songSpeed, 2) .. '\n\ncurBeat: ' .. curBeat .. '\ncurStep: ' .. curStep .. '\n\nPlayer: ' .. boyfriendName .. '\nOpponent: ' .. dadName .. '\n\nTotal Notes: ' .. hits + misses .. '\nNotes Hit: '  .. hits .. '\nNotes Missed: '  .. misses .. '\n')
		setProperty('debugBG.scale.y', 1)
	end
	screenCenter('debugInfo', 'y')
end

function round(x, n) --https://stackoverflow.com/questions/18313171/lua-rounding-numbers-and-then-truncate
    n = math.pow(10, n or 0)
    x = x * n
    if x >= 0 then x = math.floor(x + 0.5) else x = math.ceil(x - 0.5) end
    return x / n
end

function milliToHuman(milliseconds) -- https://forums.mudlet.org/viewtopic.php?t=3258
	local totalseconds = math.floor(milliseconds / 1000)
	local seconds = totalseconds % 60
	local minutes = math.floor(totalseconds / 60)
	minutes = minutes % 60
	return string.format("%02d:%02d", minutes, seconds)  
end
