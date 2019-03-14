return Def.Quad {
	InitCommand=function(self)
		self:FullScreen():diffuse(Color.Black)
	end;
	StartTransitioningCommand=function(self)
		self:diffusealpha(0):sleep(0.1):linear(0.4):diffusealpha(1)
	end;
};