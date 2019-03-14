local banner_directory = {Hearts = "Hearts", Arrows = "Arrows"}
local SongOrCourse, banner

local t =
	Def.ActorFrame {
	OnCommand = function(self)
		if IsUsingWideScreen() then
			self:zoom(0.7655)
			self:xy(_screen.cx - 170, 112)
		else
			self:zoom(0.75)
			self:xy(_screen.cx - 166, 112)
		end
	end,
	Def.ActorFrame {
		CurrentSongChangedMessageCommand = function(self)
			self:playcommand("Set")
		end,
		CurrentCourseChangedMessageCommand = function(self)
			self:playcommand("Set")
		end,
		SetCommand = function(self)
			SongOrCourse = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
			if SongOrCourse and SongOrCourse:HasBanner() then
				self:visible(false)
			else
				self:visible(true)
			end
		end,
		LoadActor(
			"colored_banners/" ..
				(banner_directory[ThemePrefs.Get("VisualTheme")] or "Hearts") ..
					"/banner" .. SL.Global.ActiveColorIndex .. " (doubleres).png"
		) ..
			{
				Name = "FallbackBanner",
				OnCommand = function(self)
					self:rotationy(180):setsize(418, 164):diffuseshift():effectoffset(3):effectperiod(6):effectcolor1(1, 1, 1, 0):effectcolor2(
						1,
						1,
						1,
						1
					)
				end
			},
		LoadActor(
			"colored_banners/" ..
				(banner_directory[ThemePrefs.Get("VisualTheme")] or "Hearts") ..
					"/banner" .. SL.Global.ActiveColorIndex .. " (doubleres).png"
		) ..
			{
				Name = "FallbackBanner",
				OnCommand = function(self)
					self:diffuseshift():effectperiod(6):effectcolor1(1, 1, 1, 0):effectcolor2(1, 1, 1, 1):setsize(418, 164)
				end
			}
	},
	Def.Sprite {
		Name = "BannerProxy",
		CurrentStepsP1ChangedMessageCommand = function(self)
			self:queuecommand("LoadBanner")
		end,
		InitCommand = function(self)
			self:scaletoclipped(capWideScale(get43size(384), 384), capWideScale(get43size(120), 120)):diffusealpha(1)
		end,
		CurrentRateChangedMessageCommand = function(self)
			self:queuecommand("LoadBanner") --steps stuff
		end,
		LoadBannerCommand = function(self)
			self:finishtweening()
			local song = GAMESTATE:GetCurrentSong()
			if song then
				local bnpath = song:GetBannerPath()
				if not bnpath then
					bnpath = THEME:GetPathG("Common", "fallback banner")
				end
				self:LoadBackground(bnpath)
			else
				local bnpath = SONGMAN:GetSongGroupBannerPath(SCREENMAN:GetTopScreen():GetMusicWheel():GetSelectedSection())
				if not bnpath or bnpath == "" then
					bnpath = THEME:GetPathG("Common", "fallback banner")
				end
				self:LoadBackground(bnpath)
			end
			self:scaletoclipped(capWideScale(get43size(384), 384), capWideScale(get43size(120), 120)):diffusealpha(1)
		end
	},
	--[[
	Def.ActorProxy{
		Name="BannerProxy",
		BeginCommand=function(self)
			banner = SCREENMAN:GetTopScreen():GetChild('Banner')
			self:SetTarget(banner)
		end
	},
	--]]
	-- the MusicRate Quad and text
	Def.ActorFrame {
		InitCommand = function(self)
			self:visible(SL.Global.ActiveModifiers.MusicRate ~= 1):y(75)
		end,
		--quad behind the music rate text
		Def.Quad {
			InitCommand = function(self)
				self:diffuse(color("#1E282FCC")):zoomto(418, 14)
			end
		},
		--the music rate text
		LoadFont("_miso") ..
			{
				InitCommand = function(self)
					self:shadowlength(1):zoom(0.85)
				end,
				OnCommand = function(self)
					self:settext(
						("%g"):format(SL.Global.ActiveModifiers.MusicRate) .. "x " .. THEME:GetString("OptionTitles", "MusicRate")
					)
				end
			}
	}
}

return t
