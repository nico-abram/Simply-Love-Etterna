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
	
	
	-- Intructions BG
	Def.Quad {
		InitCommand = function(self)
			self:xy(_screen.cx, _screen.cy-40):zoomto(_screen.w*0.75, _screen.cy*0.5):diffuse(GetCurrentColor())
		end;
	};
	-- white border
	Border(_screen.w*0.75, _screen.cy*0.5, 2) .. {
		InitCommand = function(self)
			self:xy(_screen.cx, _screen.cy-40)
		end;
	};
	
	
	
	-- Text Entry BG
	Def.Quad {
		InitCommand = function(self)
			self:xy(_screen.cx, _screen.cy+16):zoomto(_screen.w*0.75, 40):diffuse(color("#000000")): ()
		end;
	};
	-- white border
	Border(_screen.w*0.75, 40, 2) .. {
		InitCommand = function(self)
			self:xy(_screen.cx, _screen.cy+16)
		end;
	};

}
