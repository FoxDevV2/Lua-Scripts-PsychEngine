function onCreatePost()
	--Vanilla UI stuff
	setProperty('scoreTxt.visible', false)
	setProperty('timeBar.visible', false)
	setProperty('timeBarBG.visible', false)
	setProperty('timeTxt.visible', false)
	--end
	makeLuaText('sicks', 'Sicks: ' .. getProperty('sicks'), 200, 0, 355);
	makeLuaText('goods', 'Goods: ' .. getProperty('goods'), 200, 0, 380);
	makeLuaText('bads', 'Bads: ' .. getProperty('bads'), 200, 0, 405);
	makeLuaText('shits', 'Shits: ' .. getProperty('shits'), 200, 0, 430);
	makeLuaText('misses', 'Misses: ' .. getProperty('songMisses'), 200, 0, 455);
	setTextSize('sicks', 15)
	setTextSize('goods', 15)
	setTextSize('bads', 15)
	setTextSize('shits', 15)
	setTextSize('misses', 15)
	setTextAlignment('sicks', 'left')
	setTextAlignment('goods', 'left')
	setTextAlignment('bads', 'left')
	setTextAlignment('shits', 'left')
	setTextAlignment('misses', 'left')
	addLuaText('sicks');
	addLuaText('goods');
	addLuaText('bads');
	addLuaText('shits');
	addLuaText('misses');

	
	--Text Colors end
	makeLuaText('combo', 'Combo: ' .. getProperty('combo'), 200, 0, 480);
	setTextAlignment('combo', 'left')
	addLuaText('combo');
	setTextSize('combo', 16.5)
	
	makeLuaText('score', 'Score: ' .. score, 200, 0, 330);
	setTextAlignment('score', 'left')
	addLuaText('score');
	setTextAlignment('score', 'left')
	setTextSize('score', 17.5)
	
	makeLuaText('songWM', ' ' .. (songName), 500, -12.5, 692.5);
	setTextSize('songWM', 20)
	addLuaText('songWM');
	setTextAlignment('songWM', 'left')
	
	setTextString('scoreTxt', 'Rating: ' .. getProperty(rating))
end

function onRecalculateRating()
	setTextString('sicks', 'Sicks: ' .. getProperty('sicks'));
	setTextString('goods', 'Goods: ' .. getProperty('goods'));
	setTextString('bads', 'Bads: ' .. getProperty('bads'));
	setTextString('shits', 'Shits: ' .. getProperty('shits'));
	setTextString('misses', 'Misses: ' .. getProperty('songMisses'));
	setTextString('combo', 'Combo: ' .. getProperty('combo'));
	setTextString('score', 'Score:' .. score)
end