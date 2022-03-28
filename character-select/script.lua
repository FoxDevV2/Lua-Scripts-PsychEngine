---- CONFIG
-- You can edit aspects about the script below

local showSongBF = true -- Whether the chart's BF should be shown as an option, disabling might be useful if you manually registered them and the chart's BF shows wrong


local allowStoryMode = false -- If this script can be used on storymode or not
local song = 'offsetSong'; --If you want to have a song play while people are in this menu. Remove this line entirely if you don't want one.
local characterList = { -- The list of characters
	{
		name = "bf",
		displayName = "Boyfriend",
	},
	{ -- Clone this, only name and displayName are required. Make sure all commas are in place
		name = "bf", -- The json filename
		displayName = "Boyfriend w/GF and Dad", -- The name shown above the character
		opponent = "dad", -- The opponent that will be used, will use Song opponent if not specified
		gf = "gf",  -- The gf that will be used, will use Song gf if not specified
		displayNameY = 10, -- How much higher the displayname should be
	},
	{
		name = "bf-car",
		displayName = "Windy Boyfriend",
	},
	{
		name = "bf-christmas",
		displayName = "Festive Boyfriend",
	},
}


-- The actual script.

local changedChar = true
local isOnCharMenu = true;
local curCharacter = 1
local shownID = -10000
local befPaused = false
local displayNameY = 0;
local origBF = "";
local LY = 0;
local RY = 0;

function setupText(name,text,x,y)
	makeLuaText(name, text, x, y, 100);
	setTextSize(name, 48);
	setProperty(name ..'.borderColor', getColorFromHex('000000'));
	setProperty(name ..'.borderSize', 1.2);
	-- setProperty(name ..'.x', x);
	-- setProperty(name ..'.y', y);
end

function onCreate()
	--Theres nothing special here just all the extra stuff. Add or edit whatever you want.
	setupText('leftarrow', "<", getProperty("boyfriend.x") + (getProperty("boyfriend.width") * 0.2), 0)
	setupText('rightarrow', ">", getProperty("boyfriend.x") + (getProperty("boyfriend.width") * 3), 0)
	setObjectCamera('rightarrow', 'camGame');
	setObjectCamera('leftarrow', 'camGame');
	LY = getProperty('leftarrow.y')
	RY = getProperty('rightarrow.y')


	makeLuaText('displayname', characterList[curCharacter].displayName, getProperty("boyfriend.x"), getProperty("boyfriend.y"), 100);
	setProperty('displayname.borderColor', getColorFromHex('000000'));
	setProperty('displayname.borderSize', 1.2);
	setObjectCamera('displayname', 'camGame');
	setTextSize('displayname', 48);
	setTextAlignment("displayName", 'center')
	displayNameY = getProperty("displayname.y")
	addLuaText('displayname');
	cameraSetTarget("boyfriend")
	
	-- addLuaSprite('charStage', false);
	addLuaText('leftarrow', true);
	addLuaText('rightarrow', true);
	if(os ~= false) then
		os.execute('dir')
	end

	
	playMusic(song, 1, true);
	
end

function onStartCountdown()
	if(not allowStoryMode and isStoryMode)then close() end -- Close script if in story mode, remove this or n

	if not hasSelectedCharacter then
		origBF = getProperty("boyfriend.curCharacter")
		origGF = getProperty("gf.curCharacter")
		origDAD = getProperty("dad.curCharacter")
		if(showSongBF) then table.insert(characterList,1,{
			name=origBF,
			displayName="Player skin from Song"}) 
		end
		setProperty('inCutscene', true);
		setProperty('generatedMusic', false);
		setProperty('boyfriend.stunned', true);
		-- hasSelectedCharacter = true
		updateCharacter()
		setProperty('canPause', true);
		befPaused = getProperty('canPause')
		return Function_Stop;
	end
	setProperty('canPause', befPaused);
	setProperty('generatedMusic', true);
	if changedChar then
		characterPlayAnim('boyfriend', 'idle', true);

		if(characterList[curCharacter].opponent) then
			triggerEvent('Change Character', 'dad', characterList[curCharacter].opponent);
		end
		if(characterList[curCharacter].gf) then
			triggerEvent('Change Character', 'gf', characterList[curCharacter].gf);
		end
	end
	setProperty('inCutscene', false);
	setObjectCamera('boyfriend', 'camGame');
	setProperty('boyfriend.stunned', false);
	removeLuaText('leftarrow', true);
	removeLuaText('rightarrow', true);
	removeLuaText('displayname', true);
	pauseSound("music")
	
	playMusic(song, 0, false); --I don't know how to stop music there's nothing in the wiki or source its all just for sounds.\
	return Function_Continue;
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'wait' then
		startCountdown()
	end
end

function onPause()
	if(isOnCharMenu) then
		triggerEvent('Change Character', 'bf', origBF);
		isOnCharMenu = false
	end
	return Function_Continue;
end
function onUpdate()
	if isOnCharMenu == true then
		setProperty('boyfriend.stunned', true);
		-- screenCenter('displayname', 'x');
		-- screenCenter('boyfriend', 'xy');
		-- if characterList[curCharacter].y then
		-- 	setProperty("boyfriend.y",getProperty("boyfriend.y") + characterList[curCharacter].y)
		-- end
		-- if characterList[curCharacter].x then
		-- 	setProperty("boyfriend.y",getProperty("boyfriend.x") + characterList[curCharacter].x)
		-- end
		-- scaleObject('boyfriend', 1, 1);
		if(shownID ~= curCharacter) then -- Only change the character if needed
			updateCharacter()
		end
		if keyJustPressed('left') then
			curCharacter = curCharacter - 1
			playSound('scrollMenu', 1);
			setProperty('leftarrow.y',getProperty("leftarrow.y") - 5)
			setProperty('leftarrow.color',0x11aa11)
		
		elseif keyJustPressed('right') then
			curCharacter = curCharacter + 1
			playSound('scrollMenu', 1);
			setProperty('rightarrow.y',getProperty("rightarrow.y") - 5)
			setProperty('rightarrow.color',0x11aa11)

		elseif keyJustPressed('accept') then
			characterPlayAnim('boyfriend', 'hey', false);
			hasSelectedCharacter = true
			for i,v in pairs({"leftarrow","rightarrow","displayname"}) do
				
				doTweenY(v.."-y", v, getProperty(v..".y") - 20, 1, "cubeout")
				doTweenAlpha(v.."-a", v, 0, 0.7, "cubeout")
			end
			runTimer('wait', 1.8, 1);
			playSound('confirmMenu', 1);
			isOnCharMenu = false
		elseif keyJustPressed('back') then
			-- playSound('confirmMenu', 1);
			triggerEvent('Change Character', 'bf', origBF);
			isOnCharMenu = false
			hasSelectedCharacter = true
			changedChar = false
			startCountdown();
		end
		
		if keyPressed('left') then
			-- objectPlayAnimation('leftarrow', 'leftpressed', true);
			setTextSize('leftarrow', 64);
		elseif keyPressed('right') then
			-- objectPlayAnimation('rightarrow', 'rightpressed', true);
			setTextSize('rightarrow', 64);
		end
		
		if keyReleased('left') then
			-- objectPlayAnimation('leftarrow', 'leftunpressed', true);
			setTextSize('leftarrow', 48);
			setProperty('leftarrow.y',LY)
			setProperty('leftarrow.color',0xFFFFFF)
		elseif keyReleased('right') then
			-- objectPlayAnimation('rightarrow', 'rightunpressed', true);
			setTextSize('rightarrow', 48);
			setProperty('rightarrow.y',RY)
			setProperty('rightarrow.color',0xFFFFFF)
		end
		
		if curCharacter > #characterList then
			curCharacter = 1
		elseif curCharacter <= 0 then
			curCharacter = #characterList
		end
	end
end

function updateCharacter()
	triggerEvent('Change Character', 'bf', characterList[curCharacter].name);
	setTextString('displayname', characterList[curCharacter].displayName);

	-- setObjectCamera('boyfriend', 'camOther');
	characterPlayAnim('boyfriend', 'idle', true);
	shownID = curCharacter

	triggerEvent('Change Character', 'dad', characterList[curCharacter].opponent or origDAD);
	triggerEvent('Change Character', 'gf', characterList[curCharacter].gf or origGF);
	
	if characterList[curCharacter].displayNameY then
		-- scaleObject('boyfriend', 0.9, 0.9);
		setProperty('displayname.y', displayNameY-characterList[curCharacter].displayNameY); -- Inverted for easier editing
	else
		setProperty('displayname.y', displayNameY);
	end
end



-- Credits:


-- XpsxExp#4452: Making the script

-- Superpowers04#3887: Reformatting the script and making it cleaner and such
