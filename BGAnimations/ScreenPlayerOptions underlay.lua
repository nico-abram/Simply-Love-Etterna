return Def.ActorFrame{
	OnCommand=function(self)
		self:diffusealpha(0):linear(0.2):diffusealpha(1)
	end,
	OffCommand=function(self)
		self:linear(0.2):diffusealpha(0)
	end,
	
	Def.Quad{
		Name="ExplanationBackground",
		InitCommand=function(self)
			self:diffuse(color("0,0,0,0.8")):xy(_screen.cx, _screen.h-57)
		end,
		OnCommand=function(self)
			self:zoomto(_screen.w*0.935, _screen.h*0.08)
		end,
	}
}