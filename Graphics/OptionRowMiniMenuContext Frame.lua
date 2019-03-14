local t = Def.ActorFrame{};

-- a row
t[#t+1] = Def.Quad {
	OnCommand=function(self)
		self:zoomto(200,_screen.h*0.05)
	end;
};

return t;