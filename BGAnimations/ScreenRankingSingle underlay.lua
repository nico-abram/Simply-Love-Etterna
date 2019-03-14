return Def.ActorFrame{

	-- the vertical colored bands
	Def.Quad{
		InitCommand=function(self)
			self:stretchto(415,78,515,402):diffuse(PlayerColor(PLAYER_1))
		end,
		OnCommand=function(self)
			self:diffusealpha(0):linear(.5):diffusealpha(1)
		end
	},

	Def.Quad{
		InitCommand=function(self)
			self:stretchto(515,78,615,402):diffuse(PlayerColor(PLAYER_2))
		end,
		OnCommand=function(self)
			self:diffusealpha(0):linear(.5):diffusealpha(1)
		end
	},


	--masking quads
	Def.Quad{
		InitCommand=function(self)
			self:stretchto(0,_screen.cy-162,_screen.w,0):MaskSource(false): ()
		end
	},

	Def.Quad{
		InitCommand=function(self)
			self:stretchto(0,_screen.cy+162,_screen.w,_screen.h):MaskSource(false): ()
		end
	},


	--the gray bars
	Def.Quad{
		InitCommand=function(self)
			self:diffuse(color("0.6,0.6,0.6,1")):zoomto(_screen.w, 2)
		end,
		OnCommand=function(self)
			self:x(_screen.cx):y(_screen.cy-163):diffusealpha(0):linear(0.5):diffusealpha(1)
		end
	},
	Def.Quad{
		InitCommand=function(self)
			self:diffuse(color("0.6,0.6,0.6,1")):zoomto(_screen.w, 2)
		end,
		OnCommand=function(self)
			self:x(_screen.cx):y(_screen.cy+163):diffusealpha(0):linear(0.5):diffusealpha(1)
		end
	}
}