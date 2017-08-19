local player = ...

if SL[ToEnumShortString(player)].ActiveModifiers.DensityGraph == "Disabled" then
	return Def.Actor{ InitCommand=function(self) self:visible(false) end }
end

local left = WideScale(27,84) + 20
local right = _screen.cx - _screen.w/9
local width = right - left
local height = 30

local SongNumberInCourse = 0

local function getCurrentSteps()
	local steps, song

	if GAMESTATE:IsCourseMode() then
		local trailEntry = GAMESTATE:GetCurrentTrail(player):GetTrailEntries()[SongNumberInCourse+1]
		steps = trailEntry:GetSteps()
		song = trailEntry:GetSong()
	else
		steps = GAMESTATE:GetCurrentSteps(player)
		song = GAMESTATE:GetCurrentSong()
	end

	return {steps=steps, song=song}
end

local af = Def.ActorFrame{
	InitCommand=function(self)
		self:xy(left, 56 - height / 2)

		if player == PLAYER_2 then
			self:x( _screen.w - left - width)
		end
		
		self:queuecommand("Sample")
	end,
	CurrentSongChangedMessageCommand=function(self)
		self:queuecommand("Reinitalize")
	end,
	ReinitalizeCommand=function(self)
		self:playcommand("ChangeSteps", getCurrentSteps())
		SongNumberInCourse = SongNumberInCourse + 1
	end,
	SampleCommand=function(self)
		local second = GAMESTATE:GetSongPosition():GetMusicSeconds()
		self:playcommand("ChangeSongProgress", {second=second})
		self:sleep(0.1):queuecommand("Sample")
	end
}

af[#af+1] = CreateDensityGraph(width, height)

return af

