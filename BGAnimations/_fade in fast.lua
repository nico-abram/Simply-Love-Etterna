return Def.Quad {
	InitCommand=function(self)
		self:FullScreen()
	end;
	StartTransitioningCommand=function(self)
		self:diffusealpha(1):linear(0.2):diffusealpha(0)
	end;
};
