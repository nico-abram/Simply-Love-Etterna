local t = Def.ActorFrame{};

-- a row
t[#t+1] = Def.Quad {
	OnCommand=function(self)
		self:zoomto(_screen.w*0.85,_screen.h*0.0625)
	end;
};

return t;