﻿print('LOADED TEMPLATE')

TEMPLATE = {}

-- Taro's janky "TEMPLATE 1" implementation for FNF
-- shoutouts to Kade for letting me do this

-- PSYCH IMPROVED VERSION [README]
-- you can also call it "mirinmania" lol
-- it's a 2D modchart system so it don't support zIndex
-- use dofile or addLuaScript to call the modchart template in order to write mods
-- use psych engine 0.7 or higher version
-- because of some reasons, i can't add some mods
-- i don't want to add offsets and periods to old mods
-- tips: if you feel uncomfortable about path mods, set other helper mods
-- <<<<<
-- if you want to try other mods, download my alt stuff:
-- https://github.com/159357159357asdfghjkl/troll-engine-but-more-modifiers-and-shit-freeplay
-- based on troll engine
-- >>>>>
-- <--Warning: DO NOT CHANGE ALL THE FUNCTIONS EXCEPT run()-->

-- EASING EQUATIONS

---------------------------------------------------------------------------------------
----------------------DON'T TOUCH IT KIDDO---------------------------------------------
---------------------------------------------------------------------------------------
			
-- Adapted from
-- Tweener's easing functions (Penner's Easing Equations)
-- and http://code.google.com/p/tweener/ (jstweener javascript version)
--

--[[
Disclaimer for Robert Penner's Easing Equations license:

TERMS OF USE - EASING EQUATIONS

Open source under the BSD License.

Copyright © 2001 Robert Penner
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
    * Neither the name of the author nor the names of contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 'AS IS' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]

-- For all easing functions:
-- t = elapsed time
-- b = begin
-- c = change == ending - beginning
-- d = duration (total time)

local pow = math.pow
local sin = math.sin
local cos = math.cos
local pi = math.pi
local sqrt = math.sqrt
local abs = math.abs
local asin  = math.asin

function linear(t, b, c, d)
  return c * t / d + b
end

function inQuad(t, b, c, d)
  t = t / d
  return c * pow(t, 2) + b
end

function outQuad(t, b, c, d)
  t = t / d
  return -c * t * (t - 2) + b
end

function inOutQuad(t, b, c, d)
  t = t / d * 2
  if t < 1 then
    return c / 2 * pow(t, 2) + b
  else
    return -c / 2 * ((t - 1) * (t - 3) - 1) + b
  end
end

function outInQuad(t, b, c, d)
  if t < d / 2 then
    return outQuad (t * 2, b, c / 2, d)
  else
    return inQuad((t * 2) - d, b + c / 2, c / 2, d)
  end
end

function inCubic (t, b, c, d)
  t = t / d
  return c * pow(t, 3) + b
end

function outCubic(t, b, c, d)
  t = t / d - 1
  return c * (pow(t, 3) + 1) + b
end

function inOutCubic(t, b, c, d)
  t = t / d * 2
  if t < 1 then
    return c / 2 * t * t * t + b
  else
    t = t - 2
    return c / 2 * (t * t * t + 2) + b
  end
end

function outInCubic(t, b, c, d)
  if t < d / 2 then
    return outCubic(t * 2, b, c / 2, d)
  else
    return inCubic((t * 2) - d, b + c / 2, c / 2, d)
  end
end

function inQuart(t, b, c, d)
  t = t / d
  return c * pow(t, 4) + b
end

function outQuart(t, b, c, d)
  t = t / d - 1
  return -c * (pow(t, 4) - 1) + b
end

function inOutQuart(t, b, c, d)
  t = t / d * 2
  if t < 1 then
    return c / 2 * pow(t, 4) + b
  else
    t = t - 2
    return -c / 2 * (pow(t, 4) - 2) + b
  end
end

function outInQuart(t, b, c, d)
  if t < d / 2 then
    return outQuart(t * 2, b, c / 2, d)
  else
    return inQuart((t * 2) - d, b + c / 2, c / 2, d)
  end
end

function inQuint(t, b, c, d)
  t = t / d
  return c * pow(t, 5) + b
end

function outQuint(t, b, c, d)
  t = t / d - 1
  return c * (pow(t, 5) + 1) + b
end

function inOutQuint(t, b, c, d)
  t = t / d * 2
  if t < 1 then
    return c / 2 * pow(t, 5) + b
  else
    t = t - 2
    return c / 2 * (pow(t, 5) + 2) + b
  end
end

function outInQuint(t, b, c, d)
  if t < d / 2 then
    return outQuint(t * 2, b, c / 2, d)
  else
    return inQuint((t * 2) - d, b + c / 2, c / 2, d)
  end
end

function inSine(t, b, c, d)
  return -c * cos(t / d * (pi / 2)) + c + b
end

function outSine(t, b, c, d)
  return c * sin(t / d * (pi / 2)) + b
end

function inOutSine(t, b, c, d)
  return -c / 2 * (cos(pi * t / d) - 1) + b
end

function outInSine(t, b, c, d)
  if t < d / 2 then
    return outSine(t * 2, b, c / 2, d)
  else
    return inSine((t * 2) -d, b + c / 2, c / 2, d)
  end
end

function inExpo(t, b, c, d)
  if t == 0 then
    return b
  else
    return c * pow(2, 10 * (t / d - 1)) + b - c * 0.001
  end
end

function outExpo(t, b, c, d)
  if t == d then
    return b + c
  else
    return c * 1.001 * (-pow(2, -10 * t / d) + 1) + b
  end
end

function inOutExpo(t, b, c, d)
  if t == 0 then return b end
  if t == d then return b + c end
  t = t / d * 2
  if t < 1 then
    return c / 2 * pow(2, 10 * (t - 1)) + b - c * 0.0005
  else
    t = t - 1
    return c / 2 * 1.0005 * (-pow(2, -10 * t) + 2) + b
  end
end

function outInExpo(t, b, c, d)
  if t < d / 2 then
    return outExpo(t * 2, b, c / 2, d)
  else
    return inExpo((t * 2) - d, b + c / 2, c / 2, d)
  end
end

function inCirc(t, b, c, d)
  t = t / d
  return(-c * (sqrt(1 - pow(t, 2)) - 1) + b)
end

function outCirc(t, b, c, d)
  t = t / d - 1
  return(c * sqrt(1 - pow(t, 2)) + b)
end

function inOutCirc(t, b, c, d)
  t = t / d * 2
  if t < 1 then
    return -c / 2 * (sqrt(1 - t * t) - 1) + b
  else
    t = t - 2
    return c / 2 * (sqrt(1 - t * t) + 1) + b
  end
end

function outInCirc(t, b, c, d)
  if t < d / 2 then
    return outCirc(t * 2, b, c / 2, d)
  else
    return inCirc((t * 2) - d, b + c / 2, c / 2, d)
  end
end

function inElastic(t, b, c, d, a, p)
  if t == 0 then return b end

  t = t / d

  if t == 1  then return b + c end

  if not p then p = d * 0.3 end

  local s

  if not a or a < abs(c) then
    a = c
    s = p / 4
  else
    s = p / (2 * pi) * asin(c/a)
  end

  t = t - 1

  return -(a * pow(2, 10 * t) * sin((t * d - s) * (2 * pi) / p)) + b
end

-- a: amplitud
-- p: period
function outElastic(t, b, c, d, a, p)
  if t == 0 then return b end

  t = t / d

  if t == 1 then return b + c end

  if not p then p = d * 0.3 end

  local s

  if not a or a < abs(c) then
    a = c
    s = p / 4
  else
    s = p / (2 * pi) * asin(c/a)
  end

  return a * pow(2, -10 * t) * sin((t * d - s) * (2 * pi) / p) + c + b
end

-- p = period
-- a = amplitud
function inOutElastic(t, b, c, d, a, p)
  if t == 0 then return b end

  t = t / d * 2

  if t == 2 then return b + c end

  if not p then p = d * (0.3 * 1.5) end
  if not a then a = 0 end

  local s

  if not a or a < abs(c) then
    a = c
    s = p / 4
  else
    s = p / (2 * pi) * asin(c / a)
  end

  if t < 1 then
    t = t - 1
    return -0.5 * (a * pow(2, 10 * t) * sin((t * d - s) * (2 * pi) / p)) + b
  else
    t = t - 1
    return a * pow(2, -10 * t) * sin((t * d - s) * (2 * pi) / p ) * 0.5 + c + b
  end
end

-- a: amplitud
-- p: period
function outInElastic(t, b, c, d, a, p)
  if t < d / 2 then
    return outElastic(t * 2, b, c / 2, d, a, p)
  else
    return inElastic((t * 2) - d, b + c / 2, c / 2, d, a, p)
  end
end

function inBack(t, b, c, d, s)
  if not s then s = 1.70158 end
  t = t / d
  return c * t * t * ((s + 1) * t - s) + b
end

function outBack(t, b, c, d, s)
  if not s then s = 1.70158 end
  t = t / d - 1
  return c * (t * t * ((s + 1) * t + s) + 1) + b
end

function inOutBack(t, b, c, d, s)
  if not s then s = 1.70158 end
  s = s * 1.525
  t = t / d * 2
  if t < 1 then
    return c / 2 * (t * t * ((s + 1) * t - s)) + b
  else
    t = t - 2
    return c / 2 * (t * t * ((s + 1) * t + s) + 2) + b
  end
end

function outInBack(t, b, c, d, s)
  if t < d / 2 then
    return outBack(t * 2, b, c / 2, d, s)
  else
    return inBack((t * 2) - d, b + c / 2, c / 2, d, s)
  end
end

function outBounce(t, b, c, d)
  t = t / d
  if t < 1 / 2.75 then
    return c * (7.5625 * t * t) + b
  elseif t < 2 / 2.75 then
    t = t - (1.5 / 2.75)
    return c * (7.5625 * t * t + 0.75) + b
  elseif t < 2.5 / 2.75 then
    t = t - (2.25 / 2.75)
    return c * (7.5625 * t * t + 0.9375) + b
  else
    t = t - (2.625 / 2.75)
    return c * (7.5625 * t * t + 0.984375) + b
  end
end

function inBounce(t, b, c, d)
  return c - outBounce(d - t, 0, c, d) + b
end

function inOutBounce(t, b, c, d)
  if t < d / 2 then
    return inBounce(t * 2, 0, c, d) * 0.5 + b
  else
    return outBounce(t * 2 - d, 0, c, d) * 0.5 + c * .5 + b
  end
end

function outInBounce(t, b, c, d)
  if t < d / 2 then
    return outBounce(t * 2, b, c / 2, d)
  else
    return inBounce((t * 2) - d, b + c / 2, c / 2, d)
  end
end

function instant()
	return 1
end

function scale(x, l1, h1, l2, h2)
	return (((x) - (l1)) * ((h2) - (l2)) / ((h1) - (l1)) + (l2))
end

function math.clamp(val,min,max)
	if val < min then return min end
	if val > max then return max end
	return val
end

function square(angle)
	local fAngle = angle % (math.pi * 2)
		--Hack: This ensures the hold notes don't flicker right before they're hit.
		if fAngle < 0.01 then
		    fAngle = fAngle + math.pi * 2;
		end
	return fAngle >= math.pi and -1.0 or 1.0;
end

function triangle( angle )
	local fAngle= angle % math.pi * 2.0;
	if fAngle < 0.0 then
		fAngle= fAngle+math.pi * 2.0;
	end
	local result= fAngle * (1 / math.pi);
	if result < .5 then
		return result * 2.0;
	elseif result < 1.5 then
		return 1.0 - ((result - .5) * 2.0);
	else
		return -4.0 + (result * 2.0);
	end
	
end

function quantize(f,interval)
return int((f+interval/2)/interval)*interval;
end

---------------------------------------------------------------------------------------
----------------------END DON'T TOUCH IT KIDDO-----------------------------------------
---------------------------------------------------------------------------------------

beat = 0
ARROW_SIZE = 112

--all of our mods, with default values
modList = {
	beat = 0,
	flip = 0,
	invert = 0,
	drunk = 0,
	tipsy = 0,
	adrunk = 0, --non conflict accent mod
	atipsy = 0, --non conflict accent mod
	bumpyx = 0,
	bumpyxoffset = 0, --helper mod
	bumpyxperiod = 0, --helper mod
	beaty = 0,
	sawtooth = 0,
	sawtoothperiod = 0, --helper mod
	digital = 0,
	digitalsteps = 0, --helper mod
	digitaloffset = 0, --helper mod
	digitalperiod = 0, --helper mod
	square = 0,
	squareoffset = 0, --helper mod
	squareperiod = 0, --helper mod
	bounce = 0,
	bounceoffset = 0, --helper mod
	bounceperiod = 0, --helper mod
	xmode = 0,
	tiny = 0, -- strength multiplier i think
	zigzag = 0,
	zigzagoffset = 0,
	zigzagperiod = 0,
	movex = 0,
	movey = 0,
	amovex = 0,
	amovey = 0,
	reverse = 0,
	split = 0,
	cross = 0,
	centered = 0,
	dark = 0,
	stealth = 0,
	alpha = 1,
	randomvanish = 0,
	blink = 0,
	confusion = 0,
	dizzy = 0,
	wave = 0,
	brake = 0,
	boost = 0,
	boomerang = 0,
	hidden = 0,
	hiddenoffset = 0,
	sudden = 0,
	suddenoffset = 0,
	alternate = 0,
	camx = 0,
	camy = 0,
	rotationz = 0,
	camwag = 0,
	xmod = getProperty('SONG.speed'), --scrollSpeed
}

--column specific mods
for i=0,3 do
	modList['movex'..i] = 0
	modList['movey'..i] = 0
	modList['amovex'..i] = 0
	modList['amovey'..i] = 0
	modList['dark'..i] = 0
	modList['stealth'..i] = 0
	modList['confusion'..i] = 0
	modList['reverse'..i] = 0
	modList['xmod'..i] = 1 --column specific scrollSpeed multiplier
end

activeMods = {{},{}}

for pn=1,2 do
	for k,v in pairs(modList) do
		activeMods[pn][k] = v
	end
end

storedMods = {{},{}}
targetMods = {{},{}}
isTweening = {{},{}}
tweenStart = {{},{}}
tweenLen = {{},{}}
tweenCurve = {{},{}}
tweenEx1 = {{},{}}
tweenEx2 = {{},{}}
modnames = {}

function definemod(t)
	local k,v = t[1],t[2]
	if not v then v = 0 end
	for pn=1,2 do
		storedMods[pn][k] = v
		targetMods[pn][k] = v
		isTweening[pn][k] = false
		tweenStart[pn][k] = 0
		tweenLen[pn][k] = 0
		tweenCurve[pn][k] = linear
		tweenEx1[pn][k] = nil
		tweenEx2[pn][k] = nil
		if pn == 1 then
			--print('registered modifier: '..k)
			table.insert(modnames,k)
		end
	end
end

function TEMPLATE.InitMods()
	for pn=1,2 do
		for k,v in pairs(activeMods[pn]) do
			definemod{k,v}
		end
	end
end

function TEMPLATE.setup()
	--sort tables, optimization step
	function modtable_compare(a,b)
		return a[1] < b[1]
	end
	
	if table.getn(event) > 1 then
		table.sort(event, modtable_compare)
	end
	if table.getn(mods) > 1 then
		table.sort(mods, modtable_compare)
	end
end



function receptorAlpha(iCol,pn)
	local alp = 1
	
	local m = activeMods[pn]
	
	if m.alpha ~= 1 then
		alp = alp*m.alpha
	end
	if m.dark ~= 0 or m['dark'..iCol] ~= 0 then
		alp = alp*(1-m.dark)*(1-m['dark'..iCol])
	end
	
	return alp
end

function arrowAlpha(fYOffset, iCol,pn)
	local alp = 1
	
	local m = activeMods[pn]
	
	if m.alpha ~= 1 then
		alp = alp*m.alpha
	end
	if m.stealth ~= 0 or m['stealth'..iCol] ~= 0 then
		alp = alp*(1-m.stealth)*(1-m['stealth'..iCol])
	end
	if m.hidden ~= 0 then
		if fYOffset < m.hiddenoffset and fYOffset >= m.hiddenoffset-200 then
			local hmult = -(fYOffset-m.hiddenoffset)/200
			alp = alp*(1-hmult)*m.hidden
		elseif fYOffset < m.hiddenoffset-100 then
			alp = alp*(1-m.hidden)
		end
	end
	if m.sudden ~= 0 then
		if fYOffset > m.suddenoffset and fYOffset <= m.suddenoffset+200 then
			local hmult = -(fYOffset-m.suddenoffset)/200
			alp = alp*(1-hmult)*m.sudden
		elseif fYOffset > m.suddenoffset+100 then
			alp = alp*(1-m.sudden)
		end
	end
	if m.blink ~= 0 then
		local time = getSongPosition()/1000
		local f = math.sin(time*10)
		f=quantize(f,0.3333)
		alp = alp + scale( f, 0, 1, -1, 0 );
	end
	if m.randomvanish ~= 0 then
		local fRealFadeDist = 80;
		alp = alp + scale( math.abs(fYOffset-360), fRealFadeDist, 2*fRealFadeDist, -1, 0 ) * m.randomvanish;
	end
	return alp
end

function getReverseForCol(iCol,pn)
	local m = activeMods[pn]
	local val = 0
	
	val = val+m.reverse+m['reverse'..iCol]
	
	if m.split ~= 0 and iCol > 1 then val = val+m.split end
	if m.cross ~= 0 and iCol == 1 or iCol == 2 then val = val+m.cross end
	if m.alternate ~= 0 and iCol % 2 == 1 then val = val+m.alternate end
	if m.centered ~= 0 then val = scale( m.centered, 0, 1, val, 0 ) end

	return val
end

function getYAdjust(fYOffset, iCol, pn)
	
	local m = activeMods[pn]
	
	local yadj = 0
	if m.wave ~= 0 then
		yadj = yadj + m.wave * 20*math.sin( (fYOffset+250)/76 )
	end
	
	if m.brake ~= 0 then

		local fEffectHeight = 500;
		local fScale = scale( fYOffset, 0, fEffectHeight, 0, 1 )
		local fNewYOffset = fYOffset * fScale; 
		local fBrakeYAdjust = m.brake * (fNewYOffset - fYOffset)
		
		fBrakeYAdjust = math.clamp( fBrakeYAdjust, -400, 400 )
		yadj = yadj+fBrakeYAdjust;
	
	end

	if m.boost ~= 0 then

		local fEffectHeight = 500;
		local fNewYOffset = fYOffset * 1.5 / ((fYOffset+fEffectHeight/1.2)/fEffectHeight); 
		local fAccelYAdjust = m.boost * (fNewYOffset - fYOffset)
		
		fAccelYAdjust = math.clamp( fAccelYAdjust, -400, 400 )
		yadj = yadj+fAccelYAdjust;
	
	end

	if m.boomerang ~= 0 then
		yadj = ((-1*fYOffset*fYOffset/500) + 1.5*fYOffset)*m.boomerang
	end

	fYOffset = fYOffset+yadj
	
	return fYOffset
end

function arrowEffects(fYOffset, iCol, pn)
    local m = activeMods[pn]
	
    local xpos, ypos, rotz = 0, 0, 0
	
	if m['confusion'..iCol] ~= 0 or m.confusion ~= 0 then
		rotz = rotz + m['confusion'..iCol] + m.confusion
	end
	if m.dizzy ~= 0 then
		rotz = rotz + m.dizzy*fYOffset
	end
	
    if m.drunk ~= 0 then
        xpos = xpos + m.drunk * ( math.cos( getSongPosition()*0.001 + iCol*(0.2) + 1*(0.2) + fYOffset*(10)/720) * ARROW_SIZE*0.5 )
    end
    if m.tipsy ~= 0 then
        ypos = ypos + m.tipsy * ( math.cos( getSongPosition()*0.001 *(1.2) + iCol*(2.0) + 1*(0.2) ) * ARROW_SIZE*0.4 )
    end
    if m.adrunk ~= 0 then
        xpos = xpos + m.adrunk * ( math.cos( getSongPosition()*0.001 + iCol*(0.2) + 1*(0.2) + fYOffset*(10)/720) * ARROW_SIZE*0.5 )
    end
    if m.atipsy ~= 0 then
        ypos = ypos + m.atipsy * ( math.cos( getSongPosition()*0.001 *(1.2) + iCol*(2.0) + 1*(0.2) ) * ARROW_SIZE*0.4 )
    end
	
	if m['movex'..iCol] ~= 0 or m.movex ~= 0 then
		xpos = xpos + m['movex'..iCol] + m.movex
	end
	if m['amovex'..iCol] ~= 0 or m.amovex ~= 0 then
		xpos = xpos + m['amovex'..iCol] + m.amovex
	end
	if m['movey'..iCol] ~= 0 or m.movey ~= 0 then
		ypos = ypos + m['movey'..iCol] + m.movey
	end
	if m['amovey'..iCol] ~= 0 or m.amovey ~= 0 then
		ypos = ypos + m['amovey'..iCol] + m.amovey
	end
	
	if m['reverse'..iCol] ~= 0 or m.reverse ~= 0 or m.split ~= 0 or m.cross ~= 0 or m.alternate ~= 0 or m.centered ~= 0 then
		ypos = ypos + getReverseForCol(iCol,pn) * 450
	end
	
	if m.flip ~= 0 then
		local fDistance = ARROW_SIZE * 2 * (1.5 - iCol);
		xpos = xpos + fDistance * m.flip;
	end

	if m.invert ~= 0 then
		local fDistance = ARROW_SIZE * (iCol%2 == 0 and 1 or -1);
		xpos = xpos + fDistance * m.invert;
	end
	
	if m.beat ~= 0 then
			
		local fBeatStrength = m.beat;
		
		local fAccelTime = 0.3;
		local fTotalTime = 0.7;
		
		-- If the song is really fast, slow down the rate, but speed up the
		-- acceleration to compensate or it'll look weird.
		fBeat = beat + fAccelTime;
		
		local bEvenBeat = false;
		if math.floor(fBeat) % 2 ~= 0 then
			bEvenBeat = true;
		end
		
		fBeat = fBeat-math.floor( fBeat );
		fBeat = fBeat+1;
		fBeat = fBeat-math.floor( fBeat );
		
		if fBeat<fTotalTime then
		
			local fAmount = 0;
			if fBeat < fAccelTime then
				fAmount = scale( fBeat, 0.0, fAccelTime, 0.0, 1.0);
				fAmount = fAmount*fAmount;
			else 
				--fBeat < fTotalTime
				fAmount = scale( fBeat, fAccelTime, fTotalTime, 1.0, 0.0);
				fAmount = 1 - (1-fAmount) * (1-fAmount);
			end

			if bEvenBeat then
				fAmount = fAmount*-1;
			end

			local fShift = 40.0*fAmount*math.sin( ((fYOffset/30.0)) + (math.pi/2) );
			
			xpos = xpos + fBeatStrength * fShift
			
		end
	
	end

	if m.beaty ~= 0 then
			
		local fBeatStrength = m.beaty;
		
		local fAccelTime = 0.3;
		local fTotalTime = 0.7;
		
		-- If the song is really fast, slow down the rate, but speed up the
		-- acceleration to compensate or it'll look weird.
		fBeat = beat + fAccelTime;
		
		local bEvenBeat = false;
		if math.floor(fBeat) % 2 ~= 0 then
			bEvenBeat = true;
		end
		
		fBeat = fBeat-math.floor( fBeat );
		fBeat = fBeat+1;
		fBeat = fBeat-math.floor( fBeat );
		
		if fBeat<fTotalTime then
		
			local fAmount = 0;
			if fBeat < fAccelTime then
				fAmount = scale( fBeat, 0.0, fAccelTime, 0.0, 1.0);
				fAmount = fAmount*fAmount;
			else 
				--fBeat < fTotalTime
				fAmount = scale( fBeat, fAccelTime, fTotalTime, 1.0, 0.0);
				fAmount = 1 - (1-fAmount) * (1-fAmount);
			end

			if bEvenBeat then
				fAmount = fAmount*-1;
			end

			local fShift = 40.0*fAmount*math.sin( ((fYOffset/30.0)) + (math.pi/2) );
			
			ypos = ypos + fBeatStrength * fShift
			
		end
	
	end

	if m.sawtooth ~= 0 then
		xpos = xpos + (m.sawtooth*ARROW_SIZE) * ((0.5 / (m.sawtoothperiod+1) * fYOffset) / ARROW_SIZE - math.floor((0.5 / (m.sawtoothperiod+1) * fYOffset) / ARROW_SIZE) );
	end

	if m.digital ~= 0 then
		xpos = xpos + (m.digital * ARROW_SIZE * 0.5) * round((m.digitalsteps+1) * math.sin(math.pi * (fYOffset + (1.0 * m.digitaloffset ) ) / (ARROW_SIZE + (m.digitalperiod * ARROW_SIZE) )) )/(m.digitalsteps+1);
	end

	if m.bumpyx ~= 0 then
		xpos = xpos + m.bumpyx * 40*math.sin((fYOffset+(100.0*m.bumpyxoffset))/((m.bumpyxperiod*16.0)+16.0));
	end

	if m.square ~= 0 then
		local fResult = square( (math.pi * (fYOffset+(1.0*(m.squareoffset))) / (ARROW_SIZE+(m.squareperiod*ARROW_SIZE))) );
		xpos = xpos + (m.square * ARROW_SIZE * 0.5) * fResult;
	end

	if m.bounce ~= 0 then
		local fBounceAmt = math.abs( math.sin( ( (fYOffset + (1.0 * (m.bounceoffset) ) ) / ( 60 + m.bounceperiod*60) ) ) );
		xpos = xpos + m.bounce * ARROW_SIZE * 0.5 * fBounceAmt;
	end

	if m.xmode ~= 0 then
		xpos = xpos + m.xmode * (pn == 2 and -fYOffset or fYOffset)
	end

	if m.tiny ~= 0 then
		local fTinyPercent = m.tiny
		fTinyPercent = math.min( math.pow(0.5, fTinyPercent), 2 );
		xpos = xpos * fTinyPercent
	end

	if m.zigzag ~= 0 then
		local fResult = triangle( (math.pi * (1/(m.zigzagperiod+1)) * 
		((fYOffset+(100.0*(m.zigzagoffset)))/ARROW_SIZE) ) );
	    
		xpos = xpos + (m.zigzag*ARROW_SIZE/2) * fResult;
	end

    return xpos, ypos, rotz
    
end




defaultPositions = {{x=0,y=0},{x=0,y=0},{x=0,y=0},{x=0,y=0},{x=0,y=0},{x=0,y=0},{x=0,y=0},{x=0,y=0}}



-- events

mods,curmod = {},1
perframe = {}
event,curevent = {},1
songStarted = false

--make it functional, you can also choose the table ver
function modease(beat,length,ease,val,modname,playernum,plrs,startval,timin,ex1s,ex2s)
	me{beat,length,ease,startVal=val,modname,pn=playernum,timing=timin,plr=plrs,ex1=ex1s,ex2=ex2s}
end
function setvalue(beat,val,name,playernum)
	set{beat,val,name,pn=playernum}
end
function modperframe(starts,ends,func)
	mpf{starts,ends,func}
end
function callbackevent(startbeat,func,idk)
	m2{startbeat,func,idk}
end
--

function set(t)
	table.insert(mods,{t[1],0,linear,t[2],t[3],pn=t.pn})
end
function me(t)
	table.insert(mods,t)
end
function mpf(t)
	table.insert(perframe,t)
end
function m2(t)
	table.insert(event,t)
end

function TEMPLATE.songStart()
    
    downscroll = false

	for i=0,7 do
        defaultPositions[i+1].x = getPropertyFromGroup("strumLineNotes",i,"x")--+(i < 4 and 20 or 0)
        defaultPositions[i+1].y = getPropertyFromGroup("strumLineNotes",i,"y")

        --print(i .. ": " .. defaultPositions[i+1].x .. " " .. defaultPositions[i+1].y)
    end
	
	--fuck it, it's mods. You don't get a say here.
	--(this is done to prevent a lot of bugs and weird cases)
	storedScrollSpeed = 1.8
	--storedScrollSpeed = scrollSpeed
	
	for pn=1,2 do
		activeMods[pn].xmod = storedScrollSpeed
	end
	
	songStarted = true
	
end

function TEMPLATE.update(elapsed)
    beat = (getSongPosition() / 1000) * (curBpm/60)
	
	--------------------------------------------------------------
	-- modified version of exschwasion's template 1 ease reader
	-- format changed to make it more mirin-like
	-- v[1]=startBeat v[2]=len/end v[3]=curve v[4]=newval v[5]=modname, v.pn=player
	-- len is now implied, but v.timing='len' or v.timing='end' for specifics
	-- v.startVal for specifying new start val
	-- v.ex1, v.ex2 for the extra params of elastic and back eases
	--------------------------------------------------------------
	
	while curmod <= #mods and beat > mods[curmod][1] do
		local v = mods[curmod]
		
		local mn = v[5]
		local dur = v[2]
		if v.timing and v.timing == 'end' then
			dur = v[2]-v[1]
		end
		
		--print('launch attack '..mn..' at beat '..v[1])
		
		if v.plr and not v.pn then v.pn = v.plr end
		
		for pn=1,2 do
			if not v.pn or pn == v.pn then
				tweenStart[pn][mn] = v[1]
				tweenLen[pn][mn] = dur
				tweenCurve[pn][mn] = v[3]
				if v.startVal then
					storedMods[pn][mn] = v.startVal
				else
					storedMods[pn][mn] = activeMods[pn][mn]
				end
				targetMods[pn][mn] = v[4]
				tweenEx1[pn][mn] = v.ex1
				tweenEx2[pn][mn] = v.ex2
				isTweening[pn][mn] = true
			end
		end
		curmod = curmod+1
	end
	
	for pn=1,2 do
		for _,v in pairs(modnames) do
			
			if isTweening[pn][v] then
				local curtime = beat - tweenStart[pn][v]
				local duration = tweenLen[pn][v]
				local startstrength = storedMods[pn][v]
				local diff = targetMods[pn][v] - startstrength
				local curve = tweenCurve[pn][v]
				local strength = curve(curtime, startstrength, diff, duration, tweenEx1[pn][v], tweenEx2[pn][v])
				activeMods[pn][v] = strength
				if beat > tweenStart[pn][v]+duration then
					isTweening[pn][v] = false
				end
			else
				activeMods[pn][v] = targetMods[pn][v]
			end
			
		end
	end
	
	----------------------------------------
	-- do this stuff every frame --
	----------------------------------------
	if #perframe>0 then
		for i=1,#perframe do
			local a = perframe[i]
			if beat > a[1] and beat < a[2] then
				a[3](beat)
			end
		end
	end
	
	-----------------------------------------
	-- event queue --event,curevent = {},1 --
	-----------------------------------------
	while curevent <= #event and beat>=event[curevent][1] do
		if event[curevent][3] or beat < event[curevent][1]+2 then
			event[curevent][2]()
		end
		curevent = curevent+1;
	end
	
	---------------------------------------
	-- ACTUALLY APPLY THE RESULTS OF THE ABOVE CALCULATIONS TO THE NOTES
	---------------------------------------

	setCamNotes(activeMods[1].camx,activeMods[1].camy,activeMods[1].rotationz + activeMods[1].camwag * math.sin(beat*math.pi))
	
	if songStarted then
		for pn=1,2 do
			local xmod = activeMods[pn].xmod
			for col=0,3 do
			
				local c = (pn-1)*4 + col
				local xp, yp, rz = arrowEffects(0, col, pn)
				local alp = receptorAlpha(col,pn)

				--print('Areceptor '..c..' is '..tostring(receptor))
			
				local defaultx, defaulty = defaultPositions[c+1].x, defaultPositions[c+1].y
				setPropertyFromGroup("strumLineNotes",c,"x",defaultx + xp)
                setPropertyFromGroup("strumLineNotes",c,"y",defaulty + yp)
                setPropertyFromGroup("strumLineNotes",c,"angle",rz)
                setPropertyFromGroup("strumLineNotes",c,"alpha",alp)

				
				--local scrollSpeed = xmod * activeMods[pn]['xmod'..col] * (1 - 2*getReverseForCol(col,pn))
				--setLaneScrollspeed(c,scrollSpeed)
				
				--print('Breceptor '..c..' is '..tostring(receptor))
				
			end
		end
		
		--for i=1,getNumberOfNotes() do
		--	local note = _G['note_'..i]

		for v = 0, getProperty("notes.length")-1 do
			if getPropertyFromGroup('notes',v,"alive") then
				
				--print(tostring(note)..' sus '..tostring(note.isSustain))
				
				local pn = 1
				if getPropertyFromGroup('notes',v,"mustPress") then pn = 2 end
				
				
				local xmod = activeMods[pn].xmod
				
				local isSus = getPropertyFromGroup('notes',v,"isSustainNote")
				--local isParent = note.isParent
				local col = getPropertyFromGroup('notes',v,"noteData")
				local c = (pn-1)*4 + col
				
				local targTime = getPropertyFromGroup('notes',v,"strumTime")
				
				local defaultx, defaulty = defaultPositions[c+1].x, defaultPositions[c+1].y

				local scrollSpeed = xmod * activeMods[pn]['xmod'..col] * (1 - 2*getReverseForCol(col,pn))
				
				local off = (1 - 2*getReverseForCol(col,pn))

				local ypos = getYAdjust(defaulty - (getSongPosition() - targTime),col,pn) * scrollSpeed * 0.45 - off
				
				local xa, ya, rz = arrowEffects(ypos-defaulty, col, pn)
				local alp = arrowAlpha(ypos-defaulty, col, pn)
				
				if getPropertyFromGroup('notes',v,"isSustainNote") --[[and not note.isParent]] then
					local ypos2 = getYAdjust(defaulty - ((getSongPosition()+.1) - targTime),col,pn) * scrollSpeed * 0.45 - off
					local xa2, ya2 = arrowEffects(ypos2-defaulty, col, pn)

					--if scrollSpeed >= 0 then
					setPropertyFromGroup("notes",v,"angle",math.deg(math.atan2(((ypos2 + ya2)-(ypos + ya))*100,(xa2-xa)*100) + math.pi/2))
					--else
					--	note.angle = 180+math.deg(math.atan2(((ypos2 + ya2)-(ypos + ya))*100,(xa2-xa)*100) + math.pi/2)
					--end
				else
					setPropertyFromGroup("notes",v,"angle",rz)
				end
            	setPropertyFromGroup("notes",v,"x",defaultx + xa + (getPropertyFromGroup('notes',v,"isSustainNote") and 35 or 0))
            	setPropertyFromGroup("notes",v,"y",ypos + ya)
            	setPropertyFromGroup("notes",v,"alpha",alp)
				
				
			end
			
		end
		
	end
	
	
end


function onCreatePost()
	for s=0,3 do
	setPropertyFromGroup("opponentStrums",s,"x",getPropertyFromGroup("opponentStrums",s,"x")+20)
	end
	TEMPLATE.InitMods()

	--WRITE MODS HERE! 
	
	run()
	
	--must be called at END of start
	TEMPLATE.setup()
	
end
function run()
if songName == 'amnehilesie' then
	-- this is a one-player-one-side modchart
definemod{'receptorscroll',0}
set{0,-320,"movex",pn=2}
set{0,0,'alpha',pn=1}
local confused = {{1.4,0.11,7.84,26.6},{1.62,0.12,9.41,26.8},{1.85,0.125,11.4,27.1},{2.12,0.14,13.9,27.3},{2.34,0.152,15.3,0},{4.88,0.167,17.1,0},{5.09,0.172,19.0,0},{5.37,0.185,21.8,0},{5.57,0.19,23.5,0},{5.86,0.209,25.0,0}}
for k,v in pairs(confused) do
set{v[1],-v[2],'flip'}
for col=0,3 do
set{v[3],v[2]*math.random(-100,100),'confusion'..col,pn=2}
me{27.8,2,outElastic,0,'confusion'..col,pn=2}
end
if v[4] ~= 0 then
set{v[4],math.random(0,2),'wave',pn=2}
end
end
me{7.5,2,inOutBack,0.5,'stealth',pn=2}
me{6.03,3,outExpo,2,'wave',pn=2}
set{27.6,1,'alpha',pn=2}
set{27.6,0,'stealth',pn=2}
me{27.6,1.7,inQuint,0,'wave',pn=2}
me{27.6,3,inOutElastic,-0.05,'flip',pn=2}
me{27.6,3,outCubic,1,'beat',pn=2}
me{27.6,2,outInQuart,0.5,'drunk',pn=2}
me{37.6,2,inSine,0.3,'tipsy',pn=2}
me{37.6,2,inCirc,1,'drunk',pn=2}
me{42.6,1,inSine,0.8,'tipsy',pn=2}
me{45.1,0.5,linear,0.7,'flip',pn=2}
me{45.1,0.5,outInCirc,1,'reverse',pn=2}
me{45.7,0.5,linear,1,'flip',pn=2}
me{45.7,0.5,outInCirc,0,'reverse',pn=2}
me{46.5,0.5,outElastic,0,'flip',pn=2}
me{46.5,0.5,outBack,1,'reverse',pn=2}
me{46.6,3,outInBack,0,'drunk',pn=2}
me{46.6,3,outInQuad,0,'tipsy',pn=2}
me{46.6,3,outInQuad,0,'beat',pn=2}
me{48.1,1,inCubic,0.6,'dark',pn=2}
me{48.1,2,outCubic,0,'reverse',pn=2}
mpf{48,72,function(beat)
	local pn = 2
		activeMods[pn].movex = 32 * math.sin(beat * math.pi) - 320
		activeMods[1].rotationz = beat-48
		activeMods[1].camx = beat-48
end}
me{69,3,inSine,0,'alpha',pn=2}
me{72.1,1,outSine,1,'alpha',pn=2}
end
end
function onSongStart()
    
    TEMPLATE.songStart()
	
	--for i=0,7,1 do
	--	print('default position '..i..' = '..defaultPositions[i+1].x)
	--end
	
end

function onUpdatePost(elapsed)
	TEMPLATE.update(elapsed)
end

return 0