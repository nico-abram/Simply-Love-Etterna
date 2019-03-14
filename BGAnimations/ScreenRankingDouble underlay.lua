return Def.ActorFrame{
	
	OffCommand=function(self)
		self:linear(0.4):diffusealpha(0)
	end;
		
	-- the vertical colored bands
	Def.Quad{
		OnCommand=function(self)
			self:stretchto(415,78,515,402):diffuse(PlayerColor(PLAYER_1))
		end;
	};
	
	Def.Quad{
		OnCommand=function(self)
			self:stretchto(515,78,615,402):diffuse(PlayerColor(PLAYER_2))
		end;
	};


	--masking quads
	--top mask
	Def.Quad{
		OnCommand=function(self)
			self:stretchto(SCREEN_LEFT,_screen.cy-162,SCREEN_RIGHT,SCREEN_TOP):MaskSource(false)
		end;
	};
	
	--bottom mask
	Def.Quad{
		OnCommand=function(self)
			self:stretchto(SCREEN_LEFT,_screen.cy+162,SCREEN_RIGHT,SCREEN_BOTTOM):MaskSource(false)
		end;
	};
	
	
	--the gray bars
	Def.Quad{
		InitCommand=function(self)
			self:diffuse(color("0.6,0.6,0.6,1")):zoomto(_screen.w, 2)
		end;
		OnCommand=function(self)
			self:x(_screen.cx):y(_screen.cy-163)
		end;
	};
	Def.Quad{
		InitCommand=function(self)
			self:diffuse(color("0.6,0.6,0.6,1")):zoomto(_screen.w, 2)
		end;
		OnCommand=function(self)
			self:x(_screen.cx):y(_screen.cy+163)
		end;
	};
	
};