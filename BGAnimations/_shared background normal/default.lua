-- the best way to spread holiday cheer is singing loud for all to hear
if PREFSMAN:GetPreference("EasterEggs") and MonthOfYear() == 11 then
	return LoadActor(THEME:GetPathB("", "_shared background normal/snow.lua"))
end

local file = THEME:GetPathB("", "_shared background normal/" .. ThemePrefs.Get("VisualTheme") .. ".png")

-- this variable will be used within the scope of this file like (index+1) and (index-1)
-- to continue to diffuse each sprite as we shift through the colors available in SL.Colors
local index = SL.Global.ActiveColorIndex

-- time in seconds for the first NewColor (which is triggered from AF's InitCommand)
-- should be 0 so that children sprites get colored properly immediately; we'll
-- change this variable in the AF's OnCommand so that color-shifts tween appropriately
local delay = 0

local af =
	Def.ActorFrame {
	Def.Quad {
		InitCommand = function(self)
			self:FullScreen():Center():diffuse(ThemePrefs.Get("RainbowMode") and Color.White or Color.Black)
		end,
		BackgroundImageChangedMessageCommand = function(self)
			THEME:ReloadMetrics()
			SL.Global.ActiveColorIndex = ThemePrefs.Get("RainbowMode") and 3 or ThemePrefs.Get("SimplyLoveColor")
			self:linear(1):diffuse(ThemePrefs.Get("RainbowMode") and Color.White or Color.Black)
		end
	}
}

-- --------------------------------------------------------
-- non-RainbowMode (normal) background

local file_info = {
	ColorRGB = {0, 1, 1, 0, 0, 0, 1, 1, 1, 1},
	diffusealpha = {0.05, 0.2, 0.1, 0.1, 0.1, 0.1, 0.1, 0.05, 0.1, 0.1},
	xy = {0, 40, 80, 120, 200, 280, 360, 400, 480, 560},
	texcoordvelocity = {
		{0.03, 0.01},
		{0.03, 0.02},
		{0.03, 0.01},
		{0.02, 0.02},
		{0.03, 0.03},
		{0.02, 0.02},
		{0.03, 0.01},
		{-0.03, 0.01},
		{0.05, 0.03},
		{0.03, 0.04}
	}
}

local t =
	Def.ActorFrame {
	InitCommand = function(self)
		if ThemePrefs.Get("RainbowMode") then
			self:visible(false)
		else
			self:diffusealpha(0)
		end
	end,
	OnCommand = function(self)
		self:accelerate(0.8):diffusealpha(1)
	end,
	BackgroundImageChangedMessageCommand = function(self)
		if not ThemePrefs.Get("RainbowMode") then
			self:visible(true):linear(0.6):diffusealpha(1)
		else
			self:linear(0.6):diffusealpha(0):queuecommand("Hide")
		end
	end,
	HideCommand = function(self)
		self:visible(false)
	end
}

for i = 1, 10 do
	t[#t + 1] =
		Def.Sprite {
		Texture = file,
		InitCommand = function(self)
			self:diffuse(ColorRGB(file_info.ColorRGB[i]))
		end,
		ColorSelectedMessageCommand = function(self)
			self:linear(0.5):diffuse(ColorRGB(file_info.ColorRGB[i])):diffusealpha(file_info.diffusealpha[i])
		end,
		OnCommand = function(self)
			self:zoom(1.3):xy(file_info.xy[i], file_info.xy[i]):customtexturerect(0, 0, 1, 1):texcoordvelocity(
				file_info.texcoordvelocity[i][1],
				file_info.texcoordvelocity[i][2]
			):diffusealpha(file_info.diffusealpha[i])
		end,
		BackgroundImageChangedMessageCommand = function(self)
			if not ThemePrefs.Get("RainbowMode") then
				local new_file = THEME:GetPathB("", "_shared background normal/" .. ThemePrefs.Get("VisualTheme") .. ".png")
				self:Load(new_file)
			end
		end
	}
end

af[#af + 1] = t

-- --------------------------------------------------------
-- RainbowMode background

local rainbow =
	Def.ActorFrame {
	InitCommand = function(self)
		if not ThemePrefs.Get("RainbowMode") then
			self:visible(false)
		end
	end,
	OnCommand = function(self)
		self:Center():bob():effectmagnitude(0, 50, 0):effectperiod(8)
	end,
	BackgroundImageChangedMessageCommand = function(self)
		if ThemePrefs.Get("RainbowMode") then
			self:visible(true):linear(0.6):diffusealpha(1)
		else
			self:linear(0.6):diffusealpha(0):queuecommand("Hide")
		end
	end,
	HideCommand = function(self)
		self:visible(false)
	end
}

--{x,y,z,texcoordvelx,texcoordvely,alpha, IsIdxPlusOne}
local hearts =
	Def.ActorFrame {
	OnCommand = function(self)
		self:bob():effectmagnitude(0, 0, 50):effectperiod(12)
	end
}
local spriteFrame =
	Def.ActorFrame {
	InitCommand = function(self)
		self:diffusealpha(0):queuecommand("Appear"):playcommand("NewColor")
	end,
	OnCommand = function(self)
		delay = 0.7
	end,
	AppearCommand = function(self)
		self:linear(1):diffusealpha(1):queuecommand("Loop")
	end,
	BackgroundImageChangedMessageCommand = function(self)
		if ThemePrefs.Get("RainbowMode") then
			local children = self:GetChild("")

			for _, child in ipairs(children) do
				local new_file = THEME:GetPathB("", "_shared background normal/" .. ThemePrefs.Get("VisualTheme") .. ".png")
				child:Load(new_file)
			end
		end
	end,
	LoopCommand = function(self)
		index = index + 1
		self:queuecommand("NewColor")
		self:sleep(delay)
		self:queuecommand("Loop")
	end
}
local sprites = {
	{0, 0, -30, .03, .04, .3, true},
	{-50, 40, -100, .04, .01, .2, true},
	{50, -80, -100, .05, .02, .2, false},
	{-100, 120, -200, .06, .02, .2, false},
	{100, -160, -40, .07, .01, .3, true},
	{-150, 210, -50, .08, .01, .3, false},
	{150, -250, -200, .03, .03, .2, false},
	{-200, 290, -60, .03, .03, .3, true},
	{200, -330, -100, .03, .02, .2, false},
	{-250, 370, -100, .03, .03, .2, true},
	{250, -410, -50, .03, .01, .3, true},
	{-300, 450, -0, .03, .01, .2, false},
	{300, -490, -100, .03, .01, .2, true},
	{-350, 530, -100, .03, .02, .2, true},
	{350, -570, -0, .03, .01, .3, false},
	{-400, 610, -200, .04, .03, .2, true},
	{400, -650, -100, .03, .02, .2, true},
	{450, 690, -100, .02, .04, .2, true},
	{450, -730, -200, .03, .02, .2, false},
	{-500, 770, -200, .06, .01, .2, true},
	{500, -810, -100, .04, .01, .2, false},
	{-550, 850, -70, .03, .02, .2, false},
	{550, -890, -200, .02, .03, .2, false},
	{-600, 930, -100, .06, .02, .2, false},
	{600, -970, -100, .04, .04, .2, true}
}
for i, v in ipairs(sprites) do
	spriteFrame[#spriteFrame + 1] =
		Def.Sprite {
		Texture = file,
		InitCommand = function(self)
			self:zoom(1.3):x(v[1]):y(v[2]):z(v[3]):customtexturerect(0, 0, 1, 1):texcoordvelocity(v[4], v[5])
		end,
		NewColorCommand = function(self)
			self:linear(delay):diffuse(GetHexColor(index + (v[7] and 1 or -1))):diffusealpha(v[6])
		end
	}
end
hearts[#hearts + 1] = spriteFrame
rainbow[#rainbow + 1] = hearts
af[#af + 1] = rainbow
return af
