local t = Def.ActorFrame{
	Name="Text",

	EditCommand=function(self)
		self:playcommand("Show")
	end,

	PlayingCommand=function(self)
		self:playcommand("Hide")
	end,
	RecordCommand=function(self)
		self:playcommand("Hide")
	end,
	RecordPausedCommand=function(self)
		self:playcommand("Hide")
	end,

	-- Info
	Def.ActorFrame{
		InitCommand=function(self)
			self:xy(_screen.w-60, 16)
		end,
		ShowCommand=function(self)
			self:decelerate(0.1):x(_screen.w-60)
		end,
		HideCommand=function(self)
			self:accelerate(0.1):x(_screen.w+60)
		end,

		LoadFont("_miso") .. {
			Name="InfoText",
			Text=THEME:GetString("ScreenEdit","Info"),
			InitCommand=function(self)
				self:zoom(0.75)
			end
		},
		Def.Quad{
			InitCommand=function(self)
				self:y(12):zoomto(120,1)
			end
		}
	}
}

local sections = {
	NavigationHelp = 0,
	NoteWritingHelp = 106,
	MenuHelp = 254,
	RecordModeHelp = 332,
	KeyMappingHelp = 394,
	MiscHelp = 430
}

for section, offset in pairs(sections) do
	t[#t+1] = Def.ActorFrame{
		Name=section,
		InitCommand=function(self)
			self:xy(0, offset):diffusealpha(0)
		end,
		OnCommand=function(self)
			self:queuecommand("Show")
		end,
		ShowCommand=function(self)
			self:visible(true):decelerate(0.2):diffusealpha(1)
		end,
		HideCommand=function(self)
			self:diffusealpha(0):visible(false)
		end,

		LoadFont("_wendy small")..{
			Text=THEME:GetString("ScreenEdit", section.."Label"),
			InitCommand=function(self)
				self:zoom(0.265):horizalign(left):xy(35, 10):diffuse(PlayerColor(PLAYER_1))
			end
		},
		Def.Quad{
			InitCommand=function(self)
				self:y(10):zoomto(30,1):horizalign(left):diffusealpha(0.75)
			end
		},
		LoadFont("_miso")..{
			Text=THEME:GetString("ScreenEdit", section.."Text"),
			InitCommand=function(self)
				self:y(14):zoom(0.6):horizalign(left):xy(10, 20):vertalign(top):vertspacing(-1)
			end,
		},
	}
end

return t