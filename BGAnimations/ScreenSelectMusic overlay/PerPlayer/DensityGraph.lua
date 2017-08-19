local player = ...
local pn = ToEnumShortString(player)
local p = PlayerNumber:Reverse()[player]
local show = false

local function getInputHandler(actor)
    return (function (event)
        if event.GameButton == "Select" and event.PlayerNumber == player then
            if event.type == "InputEventType_FirstPress" then
                show = true
                actor:queuecommand("UpdateGraphState")
            elseif event.type == "InputEventType_Release" then
                show = false
                actor:queuecommand("UpdateGraphState")
            end
        end

        return false
    end)
end

local bannerWidth = 418
local bannerHeight = 164
local padding = 10

return Def.ActorFrame {
    -- song and course changes
    OnCommand=cmd(queuecommand, "StepsHaveChanged"),
    CurrentSongChangedMessageCommand=cmd(queuecommand, "StepsHaveChanged"),
    CurrentCourseChangedMessageCommand=cmd(queuecommand, "StepsHaveChanged"),

    InitCommand=function(self)
        local zoom, xPos

        if IsUsingWideScreen() then
            zoom = 0.7655
            xPos = 170
        else
            zoom = 0.75
            xPos = 166
        end
        
        self:zoom(zoom)
        self:xy(_screen.cx - xPos - ((bannerWidth / 2 - padding) * zoom), 112 - ((bannerHeight / 2 - padding) * zoom))

        if (player == PLAYER_2) then
            self:addy((bannerHeight / 2 - (padding * 0.5)) * zoom)
        end

        self:diffusealpha(0)
        self:queuecommand("Capture")
    end,

    CaptureCommand=function(self)
        SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self))
    end,
    
    StepsHaveChangedCommand=function(self, params)
        if show then
            self:queuecommand("UpdateGraphState")
        end
    end,

    UpdateGraphStateCommand=function(self, params)
        if show and not GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentSong() then
            local song = GAMESTATE:GetCurrentSong()
            local steps = GAMESTATE:GetCurrentSteps(player)
            self:playcommand("ChangeSteps", {song=song, steps=steps})
            self:stoptweening()
            self:linear(0.1):diffusealpha(0.9)
        else
            self:stoptweening()
            self:linear(0.1):diffusealpha(0)
        end
    end,

    CreateDensityGraph(bannerWidth - (padding * 2), bannerHeight / 2 - (padding * 1.5)),

    Def.Quad {
        InitCommand=function(self)
            self:zoomto(bannerWidth - (padding * 2), 20)
                :diffuse(color("#000000"))
                :diffusealpha(0.8)
                :align(0, 0)
                :y(bannerHeight / 2 - (padding * 1.5) - 20)
        end,
    },
    
    Def.BitmapText{
        Font="_miso",
        InitCommand=function(self)
            self:diffuse(color("#ffffff"))
                :horizalign("left")
                :y(bannerHeight / 2 - (padding * 1.5) - 20 + 2)
                :x(5)
                :maxwidth(bannerWidth - (padding * 2) - 10)
                :align(0, 0)
                :Stroke(color("#000000"))
        end,

        StepsHaveChangedCommand=function(self, params)
            if show then
                self:queuecommand("UpdateGraphState")
            end
        end,

        UpdateGraphStateCommand=function(self)
            if show and not GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentSong() then
                local song_dir = GAMESTATE:GetCurrentSong():GetSongDir()
                local steps = GAMESTATE:GetCurrentSteps(player)
                local steps_type = ToEnumShortString( steps:GetStepsType() ):gsub("_", "-"):lower()
                local difficulty = ToEnumShortString( steps:GetDifficulty() )
                local breakdown = GetStreamBreakdown(song_dir, steps_type, difficulty)
                
                if breakdown == "" then
                    self:settext("No streams!")
                else
                    self:settext("Streams: " .. breakdown)
                end
                
                return true
            end
        end
    }
}