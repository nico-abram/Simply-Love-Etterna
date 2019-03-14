return Def.ActorFrame{
	Def.Quad {
		InitCommand=function(self)
			self:diffuse(Color.Black): FullScreen()
		end,
		StartTransitioningCommand=function(self)
			self:diffusealpha(1):linear(0.4):diffusealpha(0)
		end
	}
}