return LoadFont("_wendy small") .. {
	Text="Exit";
	InitCommand=function(self)
		self:x(_screen.cx):zoom(0.5):shadowlength(0):diffuse(GetCurrentColor()):NoStroke()
	end;
	OnCommand=function(self)
		self:diffusealpha(0):decelerate(0.5):diffusealpha(1)
	end;
	OffCommand=function(self)
		self:stoptweening():accelerate(0.3):diffusealpha(0):queuecommand("Hide")
	end;
	HideCommand=function(self)
		self:visible(false)
	end;

	GainFocusCommand=function(self)
		self:diffuseshift():effectcolor1(GetHexColor((SL.Global.ActiveColorIndex-1)%12)):effectcolor2(GetHexColor((SL.Global.ActiveColorIndex+1)%12))
	end;
	LoseFocusCommand=function(self)
		self:stopeffect()
	end;
};
