return Def.ActorFrame{
	Def.Quad{
		InitCommand=function(self)
			self:FullScreen():diffuse(color("0,0,0,0"))
		end;
		OnCommand=function(self)
			self:accelerate(0.5):diffusealpha(0.5)
		end;
		OffCommand=function(self)
			self:accelerate(0.5):diffusealpha(0)
		end;
	};
	
	-- the BG for the prompt itself
	Def.Quad {
		InitCommand=function(self)
			self:xy(_screen.cx, _screen.cy-56):zoomto(_screen.w*0.75, _screen.cy*0.5):diffuse(GetCurrentColor())
		end;
	};
	-- white border
	Border(_screen.w*0.75, _screen.cy*0.5, 2) .. {
		InitCommand=function(self)
			self:xy(_screen.cx, _screen.cy-56)
		end;
	};
	
	

	-- the BG for the choices presented to the player
	Def.Quad {
		InitCommand=function(self)
			self:xy(_screen.cx, _screen.cy+120):zoomto(_screen.w*0.75, _screen.cy*0.25)
		end;
		OnCommand=function(self)
			self:diffuse(color("#000000FF"))
		end;
	};
	-- white border
	Border(_screen.w*0.75, _screen.cy*0.25, 2) .. {
		InitCommand=function(self)
			self:xy(_screen.cx, _screen.cy+120)
		end;
	};

}
