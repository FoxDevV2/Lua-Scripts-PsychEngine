local oppoY = 190
local textY = 630

credit = { -- coded by HayatoKawajiri#4229
-- Yt Channel Name: Alternative Universal UT
-- You can use this But please credit me

-- i already set everything to work fine ( downscroll middlescroll ) is all work fine i tested them
}

function onUpdate()
    --black box and Song name As a Text
    if inGameOver == false then
  	  makeLuaSprite('box', 'blackbox', 395, -950);
  	  scaleObject('box', 0.6, 3.6);
      setScrollFactor('box', 0.0001, 0.00001);
      setObjectCamera('box', 'hud')
    
      addLuaSprite('box', false);
      
      songName = getProperty('curSong')
      makeLuaText('SongText', songName, 900, 950, textY)
      setTextAlignment('SongText', 'left')
      setTextSize('SongText', 30)
 
      addLuaText('SongText')
    
      -- black box and dad note fade
    
      setProperty('box.alpha', 0.5)
    
      -- note color changing
    
      for i = 0,7 do
      setPropertyFromGroup('opponentStrums', i, 'alpha', 0.75)
      --setPropertyFromGroup('notes', i, 'colorSwap.saturation', -1)
      --setPropertyFromGroup('opponentStrums', i, 'colorSwap.saturation', -1)
      --setPropertyFromGroup('playerStrums', i, 'colorSwap.saturation', -1)
      end
    end

    
    -- check if u enable middle scroll

  if middlescroll then
  --nothing lol
  else
    opponentmove()
    MoveNote()
  end
  if downscroll then
  textY = 70
  oppoY = -200
  end
end

function MoveNote()
    noteTweenX('sus', 4, defaultPlayerStrumX0 - 320, 0.01, 'linear')
    noteTweenX('sus1', 5, defaultPlayerStrumX1 - 320, 0.01, 'linear')
    noteTweenX('sus2', 6, defaultPlayerStrumX2 - 315, 0.01, 'linear')
    noteTweenX('sus3', 7, defaultPlayerStrumX3 - 315, 0.01, 'linear')
end

function opponentmove()
    noteTweenX('sussy', 0, defaultOpponentStrumX0 - 100, 0.01, 'linear')
    noteTweenX('sussy1', 1, defaultOpponentStrumX1 - 110, 0.01, 'linear')
    noteTweenX('sussy2', 2, defaultOpponentStrumX2 - 120, 0.01, 'linear')
    noteTweenX('sussy3', 3, defaultOpponentStrumX3 - 130, 0.01, 'linear')
    noteTweenY('imposter', 0, defaultOpponentStrumY0 + oppoY, 0.01, 'linear')
    noteTweenY('imposter1', 1, defaultOpponentStrumY1 + oppoY, 0.01, 'linear')
    noteTweenY('imposter2', 2, defaultOpponentStrumY2 + oppoY, 0.01, 'linear')
    noteTweenY('imposter3', 3, defaultOpponentStrumY3 + oppoY, 0.01, 'linear')
end
