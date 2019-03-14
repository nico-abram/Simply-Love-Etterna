return Def.ActorFrame {
	LoadActor( THEME:GetPathS("", "_prompt") ) .. {
		StartTransitioningCommand=function(self)
			self:play()
		end;
	};
	
	Def.Actor {
		 OnCommand=function(self)
			self:sleep(0.3)
		end
	};
};
