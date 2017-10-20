local player = ...

if SL[ToEnumShortString(player)].ActiveModifiers.DensityGraph == "Disabled" then
	return Def.Actor{ InitCommand=function(self) self:visible(false) end }
end

local left = WideScale(27,84) + 20
local right = _screen.cx - _screen.w/9
local width = right - left
local height = 30

local SongNumberInCourse = 0
local Song, Steps, StepsType, Difficulty, TrailEntry
local PeakNPS, NPSperMeasure, PeakNPS_BMT
local TimingData, FirstSecond, TotalSeconds
local TotalMeasures
local verts

function InitializeNPSHistogram() 
	if GAMESTATE:IsCourseMode() then
			TrailEntry = GAMESTATE:GetCurrentTrail(player):GetTrailEntries()[SongNumberInCourse+1]
			Steps = TrailEntry:GetSteps()
			Song = TrailEntry:GetSong()
	else
			Steps = GAMESTATE:GetCurrentSteps(player)
			Song = GAMESTATE:GetCurrentSong()
	end

	StepsType = ToEnumShortString( Steps:GetStepsType() ):gsub("_", "-"):lower()
	Difficulty = ToEnumShortString( Steps:GetDifficulty() )

	PeakNPS, NPSperMeasure = GetNPSperMeasure(Song, StepsType, Difficulty)

	TimingData = Song:GetTimingData()

    TotalMeasures = 0
    for i, a in ipairs(NPSperMeasure) do
        TotalMeasures = TotalMeasures + 1
    end

    FirstSecond = 0
    LastSecond = TimingData:GetElapsedTimeFromBeat(TotalMeasures * 4)
    TotalSeconds = LastSecond - FirstSecond

	verts = {}
	local w = width / TotalSeconds

    for i, nps in ipairs(NPSperMeasure) do
		local x = TimingData:GetElapsedTimeFromBeat((i - 1) * 4) * w
		local x2 = TimingData:GetElapsedTimeFromBeat(i * 4) * w
		local y = -1 * scale(nps, 0, PeakNPS, 0, height)

		verts[#verts+1] = {{x, 0, 0}, {1,1,1,1}}
		verts[#verts+1] = {{x, y, 0}, {1,1,1,1}}
        verts[#verts+1] = {{x2, 0, 0}, {1,1,1,1}}
		verts[#verts+1] = {{x2, y, 0}, {1,1,1,1}}
	end
end

InitializeNPSHistogram()

if NPSperMeasure and #NPSperMeasure > 1 then
	local af = Def.ActorFrame{
		InitCommand=function(self)
            self:xy(left, 56 - height / 2)
            if player == PLAYER_2 then
                self:x( _screen.w - left - width)
            end
			
            self:queuecommand("Sample")
		end,
		OnCommand=function(self)
			LifeMeter = SCREENMAN:GetTopScreen():GetChild("Life"..ToEnumShortString(player))
		end
	}

	local bg = Def.Quad{
		InitCommand=function(self)
			self:zoomto(width,height)
				:align(0,0)
				:diffuse(color("#4D6677"))
		end
	}

	local amv = Def.ActorMultiVertex{
		Name="DensityGraph_AMV",
		InitCommand=function(self)
			self:SetDrawState{Mode="DrawMode_QuadStrip"}
				:SetVertices(verts)
				:align(0, 0)
				:x(0)
				:y(height)
				:MaskSource()
		end,
		CurrentSongChangedMessageCommand=function(self)
 			-- we've reached a new song, so reset the vertices for the density graph
 			-- this will occur at the start of each new song in CourseMode
 			-- and at the start of "normal" gameplay
 			self:queuecommand("Reinitalize")
 		end,
 		ReinitalizeCommand=function(self)
			InitializeNPSHistogram()
			SongNumberInCourse = SongNumberInCourse + 1
 			self:SetNumVertices(#verts):SetVertices(verts)
 		end
	}

	local gradient = Def.Sprite{
		Texture="./StepStatistics/DensityGraphs/NPS-gradient.png",
		InitCommand=function(self)
			self:setsize(width, height)
				:align(0,0)
				:x(0)
				:ztestmode("ZTestMode_WriteOnFail")

		end
	}

    local fg = Def.Quad{
		InitCommand=function(self)
			self:zoomto(0, height)
				:align(0,0)
				:diffuse(color("#000000"))
                :diffusealpha(0.7)
		end,

        SampleCommand=function(self)
            local second = GAMESTATE:GetSongPosition():GetMusicSeconds()
            local pos = scale(second, FirstSecond, LastSecond, 0, width)
            self:zoomto(clamp(pos + 1, 0, width), height)
			self:sleep(0.1):queuecommand("Sample")
		end
	}

	af[#af+1] = bg
	af[#af+1] = amv
	af[#af+1] = gradient
    af[#af+1] = fg

	return af
end
