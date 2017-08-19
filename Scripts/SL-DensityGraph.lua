local function getTimes(npsPerMeasure, timingData)
    if (npsPerMeasure == nil) then
        return {firstSecond=0, lastSecond=0, totalSeconds=0}
    end

    -- insane, but whatever
    local totalMeasures = 0
    for i, a in ipairs(npsPerMeasure) do
        totalMeasures = totalMeasures + 1
    end

    local firstSecond = 0
    local lastSecond = timingData:GetElapsedTimeFromBeat(totalMeasures * 4)
    local totalSeconds = lastSecond - firstSecond

    return {firstSecond=firstSecond, lastSecond=lastSecond, totalSeconds=totalSeconds}
end

function CreateDensityGraph(width, height)
    local times
    local af = Def.ActorFrame {}

    local bg = Def.Quad {
        InitCommand=function(self)
            self:zoomto(width,height)
                :align(0,0)
                :diffuse(color("#4D6677"))
        end
    }

    local amv = Def.ActorMultiVertex {
        InitCommand=function(self)
            self:SetDrawState{Mode="DrawMode_QuadStrip"}
                :align(0, 0)
                :x(0)
                :y(height)
                :MaskSource()
        end,
        ChangeStepsCommand=function(self, params)
            local song = params.song
            local steps = params.steps
            local stepsType = ToEnumShortString(steps:GetStepsType()):gsub("_", "-"):lower()
            local difficulty = ToEnumShortString(steps:GetDifficulty())
            local peakNps, npsPerMeasure = GetNPSperMeasure(song, stepsType, difficulty)
            local timingData = song:GetTimingData()

            if npsPerMeasure == nil then
                self:SetNumVertices(0)
                return
            end

            times = getTimes(npsPerMeasure, timingData)
            local verts = {}
            local w = width / times.totalSeconds

            for i, nps in ipairs(npsPerMeasure) do
                local x = timingData:GetElapsedTimeFromBeat((i - 1) * 4) * w
                local x2 = timingData:GetElapsedTimeFromBeat(i * 4) * w
                local y = -1 * scale(nps, 0, peakNps, 0, height)

                verts[#verts+1] = {{x, 0, 0}, {1,1,1,1}}
                verts[#verts+1] = {{x, y, 0}, {1,1,1,1}}
                verts[#verts+1] = {{x2, 0, 0}, {1,1,1,1}}
                verts[#verts+1] = {{x2, y, 0}, {1,1,1,1}}
            end

            self:SetVertices(verts):SetNumVertices(#verts)
        end
    }

    local gradient = Def.Sprite {
        Texture="../Graphics/NPS-gradient.png",
        InitCommand=function(self)
            self:setsize(width, height)
                :align(0,0)
                :x(0)
                :ztestmode("ZTestMode_WriteOnFail")
        end
    }

    local fg = Def.Quad {
		InitCommand=function(self)
			self:zoomto(0, height)
				:align(0,0)
				:diffuse(color("#000000"))
                :diffusealpha(0.7)
		end,

        ChangeSongProgressCommand=function(self, params)
            if not times then
                return
            end
            
            local pos = scale(params.second, times.firstSecond, times.lastSecond, 0, width)
            self:zoomto(clamp(pos + 1, 0, width), height)
        end
	}
    
    af[#af+1] = bg
    af[#af+1] = amv
    af[#af+1] = gradient
    af[#af+1] = fg
    return af
end