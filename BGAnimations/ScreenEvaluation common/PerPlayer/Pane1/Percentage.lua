local pn = ...

local stats = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
local PercentDP = stats:GetPercentDancePoints()
local percent = FormatPercentScore(PercentDP)
-- Format the Percentage string, removing the % symbol
percent = percent:gsub("%%", "")

return Def.ActorFrame{
	Name="PercentageContainer"..ToEnumShortString(pn),
	OnCommand=function(self)
		self:y( _screen.cy-26 )
		self:x( (pn == PLAYER_1 and -70) or 70 )
	end,

	-- dark background quad behind player percent score
	Def.Quad{
		InitCommand=function(self)
			self:diffuse(color("#101519")):zoomto(160,60)
		end
	},

	LoadFont("_wendy white")..{
		Text=percent,
		Name="Percent",
		InitCommand=function(self)
			self:vertalign(middle):horizalign(right):zoom(0.585)
		end,
		OnCommand=function(self)
			self:x(70)
		end
	}
}
