return Def.ActorFrame{
	Def.Quad{
		InitCommand=function(self)
			self:FullScreen():diffuse(color("#ffffff00"))
		end,
		OnCommand=function(self)
			self:decelerate(1):diffusealpha(1)
		end
	}
}