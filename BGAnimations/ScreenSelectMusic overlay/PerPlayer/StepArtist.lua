local player = ...
local pn = ToEnumShortString(player)
local p = PlayerNumber:Reverse()[player]
local showStreams = false

local function getInputHandler(actor)
	return (function (event)
		if event.GameButton == "Select" and event.PlayerNumber == player then
			if event.type == "InputEventType_FirstPress" then
				showStreams = true
				actor:queuecommand("StepsHaveChanged")
			elseif event.type == "InputEventType_Release" then
				showStreams = false
				actor:queuecommand("StepsHaveChanged")
			end
		end

		return false
	end)
end

return Def.ActorFrame{
	Name="StepArtistAF_" .. pn,
	InitCommand=cmd(draworder,1),

	-- song and course changes
	OnCommand=cmd(queuecommand, "StepsHaveChanged"),
	CurrentSongChangedMessageCommand=cmd(queuecommand, "StepsHaveChanged"),
	CurrentCourseChangedMessageCommand=cmd(queuecommand, "StepsHaveChanged"),

	PlayerJoinedMessageCommand=function(self, params)
		if params.Player == player then
			self:queuecommand("Appear" .. pn)
		end
	end,
	PlayerUnjoinedMessageCommand=function(self, params)
		if params.Player == player then
			self:ease(0.5, 275):addy(scale(p,0,1,1,-1) * 30):diffusealpha(0)
		end
	end,

	-- depending on the value of pn, this will either become
	-- an AppearP1Command or an AppearP2Command when the screen initializes
	["Appear"..pn.."Command"]=function(self) self:visible(true):ease(0.5, 275):addy(scale(p,0,1,-1,1) * 30) end,

	InitCommand=function(self)
		self:visible( false ):halign( p )

		if player == PLAYER_1 then

			self:y(_screen.cy + 44)
			self:x( _screen.cx - (IsUsingWideScreen() and 356 or 346))

		elseif player == PLAYER_2 then

			self:y(_screen.cy + 97)
			self:x( _screen.cx - 210)
		end

		if GAMESTATE:IsHumanPlayer(player) then
			self:queuecommand("Appear" .. pn)
		end

		self:queuecommand("Capture")
	end,

	CaptureCommand=function(self)
		SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self))
	end,

	-- colored background quad
	Def.Quad{
		Name="BackgroundQuad",
		InitCommand=cmd(zoomto, 175, _screen.h/28; x, 113; diffuse, DifficultyIndexColor(1) ),
		StepsHaveChangedCommand=function(self)
			local StepsOrTrail = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)

			if StepsOrTrail then
				local difficulty = StepsOrTrail:GetDifficulty()
				self:diffuse( DifficultyColor(difficulty) )
			else
				self:diffuse( PlayerColor(player) )
			end
		end
	},

	--STEPS label
	Def.BitmapText{
		Font="_miso",
		OnCommand=cmd(diffuse, color("0,0,0,1"); horizalign, left; x, 30; settext, Screen.String("STEPS"))
	},

	--stepartist text
	Def.BitmapText{
		Font="_miso",
		InitCommand=cmd(diffuse,color("#1e282f"); horizalign, left; x, 75; maxwidth, 115),
		StepsHaveChangedCommand=function(self)
			if showStreams and not GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentSong() then
				local song_dir = GAMESTATE:GetCurrentSong():GetSongDir()
				local steps = GAMESTATE:GetCurrentSteps(player)
				local steps_type = ToEnumShortString( steps:GetStepsType() ):gsub("_", "-"):lower()
				local difficulty = ToEnumShortString( steps:GetDifficulty() )
				local breakdown = GetStreamBreakdown(song_dir, steps_type, difficulty)
				
				if breakdown == "" then
					self:settext("no streams!")
				else
					self:settext(breakdown)
				end
				
				return true
			end
			
			local SongOrCourse = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
			local StepsOrCourse = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSteps(player)

			-- if we're hovering over a group title, clear the stepartist text
			if not SongOrCourse then
				self:settext("")
			elseif StepsOrCourse then
				local stepartist = GAMESTATE:IsCourseMode() and StepsOrCourse:GetScripter() or StepsOrCourse:GetAuthorCredit()
				self:settext(stepartist or "")
			end
		end
	}
}