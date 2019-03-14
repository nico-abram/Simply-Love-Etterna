local dc1 = DifficultyIndexColor(1)
local dc2 = DifficultyIndexColor(2)
local image = ThemePrefs.Get("VisualTheme")

local t = Def.ActorFrame{
	OffCommand=function(self)
		self:linear(1)
	end
}

-- centers
t[#t+1] = Def.ActorFrame {
	InitCommand=function(self)
		self:diffusealpha(0)
	end;
	OnCommand=function(self)
		self:x(_screen.cx):y(_screen.cy+50):diffusealpha(1):decelerate(0.4):addy(-250):accelerate(0.5):addy(20):diffusealpha(0)
	end;
	
	--top center
	LoadActor("ScreenTitleMenu underlay/".. image .."_flycenter") .. {
		InitCommand=function(self)
			self:diffusealpha(0)
		end;
		OnCommand=function(self)
			self:diffuse(dc2):rotationy(180):zoom(0):diffusealpha(0):accelerate(0.8):addx(50):zoom(1):diffusealpha(0.4):sleep(0):zoom(0)
		end;
	};	
	
	LoadActor("ScreenTitleMenu underlay/".. image .."_flycenter") .. {
		InitCommand=function(self)
			self:diffusealpha(0)
		end;
		OnCommand=function(self)
			self:diffuse(dc1):zoom(0):diffusealpha(0):accelerate(0.8):addx(-50):zoom(0.6):diffusealpha(0.6):sleep(0):zoom(0)
		end;
	};
}

t[#t+1] = Def.ActorFrame {
	InitCommand=function(self)
		self:diffusealpha(0)
	end;
	OnCommand=function(self)
		self:x(_screen.cx):y(_screen.cy+380):diffusealpha(1):decelerate(0.4):addy(-250):accelerate(0.5):addy(80):diffusealpha(0)
	end;
	
	--bottom center
	LoadActor("ScreenTitleMenu underlay/".. image .."_flycenter") .. {
		InitCommand=function(self)
			self:diffusealpha(0)
		end;
		OnCommand=function(self)
			self:diffuse(dc2):rotationy(180):zoom(0):diffusealpha(0):accelerate(0.8):addx(50):zoom(0.6):diffusealpha(0.6):sleep(0):zoom(0)
		end;
	};

	LoadActor("ScreenTitleMenu underlay/".. image .."_flycenter") .. {
		InitCommand=function(self)
			self:diffusealpha(0)
		end;
		OnCommand=function(self)
			self:diffuse(dc1):zoom(0):diffusealpha(0):accelerate(0.8):addx(-50):zoom(1):diffusealpha(0.4):sleep(0):zoom(0)
		end;
	};
}

-- up 200
t[#t+1] = Def.ActorFrame {
	InitCommand=function(self)
		self:diffusealpha(0)
	end;
	OnCommand=function(self)
		self:x(_screen.cx):y(_screen.cy+200):diffusealpha(1):decelerate(0.4):addy(-200):accelerate(0.5):addy(100):diffusealpha(0)
	end;
	
	--top left
	LoadActor("ScreenTitleMenu underlay/".. image .."_flytop") .. {
		InitCommand=function(self)
			self:diffusealpha(0)
		end;
		OnCommand=function(self)
			self:diffuse(dc1):rotationy(180):zoom(0):diffusealpha(0):accelerate(0.8):addx(-200):zoom(1.0):diffusealpha(0.6):sleep(0):zoom(0)
		end;
	};

	--top right
	LoadActor("ScreenTitleMenu underlay/".. image .."_flytop") .. {
		InitCommand=function(self)
			self:diffusealpha(0)
		end;
		OnCommand=function(self)
			self:diffuse(dc1):zoom(0):diffusealpha(0):accelerate(0.8):addx(200):zoom(1.0):diffusealpha(0.4):sleep(0):zoom(0)
		end;
	};
}

--up 250
t[#t+1] = Def.ActorFrame {
	InitCommand=function(self)
		self:diffusealpha(0)
	end;
	OnCommand=function(self)
		self:x(_screen.cx):y(_screen.cy+200):diffusealpha(1):decelerate(0.5):addy(-250):accelerate(0.5):addy(100):diffusealpha(0)
	end;
	
	--top left
	LoadActor("ScreenTitleMenu underlay/".. image .."_flytop") .. {
		InitCommand=function(self)
			self:diffusealpha(0)
		end;
		OnCommand=function(self)
			self:diffuse(dc2):rotationy(180):zoom(0):diffusealpha(0):accelerate(0.8):addx(-200):zoom(1.5):diffusealpha(0.3):sleep(0):zoom(0)
		end;
	};

	LoadActor("ScreenTitleMenu underlay/".. image .."_flytop") .. {
		InitCommand=function(self)
			self:diffusealpha(0)
		end;
		OnCommand=function(self)
			self:diffuse(dc1):rotationy(180):zoom(0):diffusealpha(0):accelerate(0.8):addx(-200):zoom(0.8):diffusealpha(0.6):sleep(0):zoom(0)
		end;
	};
	
	--top right
	LoadActor("ScreenTitleMenu underlay/".. image .."_flytop") .. {
		InitCommand=function(self)
			self:diffusealpha(0)
		end;
		OnCommand=function(self)
			self:diffuse(dc1):zoom(0):diffusealpha(0):accelerate(0.8):addx(200):zoom(1.5):diffusealpha(0.2):sleep(0):zoom(0)
		end;
	};

	LoadActor("ScreenTitleMenu underlay/".. image .."_flytop") .. {
		InitCommand=function(self)
			self:diffusealpha(0)
		end;
		OnCommand=function(self)
			self:diffuse(dc2):zoom(0):diffusealpha(0):accelerate(0.8):addx(200):zoom(0.8):diffusealpha(0.4):sleep(0):zoom(0)
		end;
	};
}

--up 150, out 280
t[#t+1] = Def.ActorFrame {
	InitCommand=function(self)
		self:diffusealpha(0)
	end;
	OnCommand=function(self)
		self:x(_screen.cx):y(_screen.cy+200):diffusealpha(1):decelerate(0.4):addy(-150):accelerate(0.5):addy(100):diffusealpha(0)
	end;
	
	--top left
	LoadActor("ScreenTitleMenu underlay/".. image .."_flytop") .. {
		InitCommand=function(self)
			self:diffusealpha(0)
		end;
		OnCommand=function(self)
			self:diffuse(dc1):rotationy(180):zoom(0):diffusealpha(0):accelerate(0.8):addx(-280):zoom(1.2):diffusealpha(0.6):sleep(0):zoom(0)
		end;
	};
		
	--top right
	LoadActor("ScreenTitleMenu underlay/".. image .."_flytop") .. {
		InitCommand=function(self)
			self:diffusealpha(0)
		end;
		OnCommand=function(self)
			self:diffuse(dc1):zoom(0):diffusealpha(0):accelerate(0.8):addx(280):zoom(1.2):diffusealpha(0.4):sleep(0):zoom(0)
		end;
	};
}
		
--up 250, out 280
t[#t+1] = Def.ActorFrame {
	InitCommand=function(self)
		self:diffusealpha(0)
	end;
	OnCommand=function(self)
		self:x(_screen.cx):y(_screen.cy+200):diffusealpha(1):decelerate(0.4):addy(-250):accelerate(0.5):addy(100):diffusealpha(0)
	end;
	
	--top left
	LoadActor("ScreenTitleMenu underlay/".. image .."_flytop") .. {
		InitCommand=function(self)
			self:diffusealpha(0)
		end;
		OnCommand=function(self)
			self:diffuse(dc1):rotationy(180):zoom(0):diffusealpha(0):accelerate(0.8):addx(-280):zoom(0.2):diffusealpha(0.3):sleep(0):zoom(0)
		end;
	};
	
	--top right
	LoadActor("ScreenTitleMenu underlay/".. image .."_flytop") .. {
		InitCommand=function(self)
			self:diffusealpha(0)
		end;
		OnCommand=function(self)
			self:diffuse(dc1):zoom(0):diffusealpha(0):accelerate(0.8):addx(280):zoom(0.2):diffusealpha(0.2):sleep(0):zoom(0)
		end;
	};
}	

--up 200
t[#t+1] = Def.ActorFrame {
	InitCommand=function(self)
		self:diffusealpha(0)
	end;
	OnCommand=function(self)
		self:x(_screen.cx):y(_screen.cy+200):diffusealpha(1):decelerate(0.4):addy(-200):accelerate(0.5):addy(100):diffusealpha(0)
	end;

	--bottom left
	LoadActor("ScreenTitleMenu underlay/".. image .."_flybottom") .. {
		InitCommand=function(self)
			self:diffusealpha(0)
		end;
		OnCommand=function(self)
			self:diffuse(dc1):rotationy(180):zoom(0):diffusealpha(0):accelerate(0.8):addx(-200):zoom(1.0):diffusealpha(0.3):sleep(0):zoom(0)
		end;
	};
	
	--bottom right
	LoadActor("ScreenTitleMenu underlay/".. image .."_flybottom") .. {
		InitCommand=function(self)
			self:diffusealpha(0)
		end;
		OnCommand=function(self)
			self:diffuse(dc1):zoom(0):diffusealpha(0):accelerate(0.8):addx(200):zoom(1.0):diffusealpha(0.2):sleep(0):zoom(0)
		end;
	};
}

--up 250		
t[#t+1] = Def.ActorFrame {
	InitCommand=function(self)
		self:diffusealpha(0)
	end;
	OnCommand=function(self)
		self:x(_screen.cx):y(_screen.cy+200):diffusealpha(1):decelerate(0.4):addy(-250):accelerate(0.5):addy(100):diffusealpha(0)
	end;
	
	-- bottom left
	LoadActor("ScreenTitleMenu underlay/".. image .."_flybottom") .. {
		InitCommand=function(self)
			self:diffusealpha(0)
		end;
		OnCommand=function(self)
			self:diffuse(dc2):rotationy(180):zoom(0):diffusealpha(0):accelerate(0.8):addx(-200):zoom(1.5):diffusealpha(0.6):sleep(0):zoom(0)
		end;
	};
	
	LoadActor("ScreenTitleMenu underlay/".. image .."_flybottom") .. {
		InitCommand=function(self)
			self:diffusealpha(0)
		end;
		OnCommand=function(self)
			self:diffuse(dc1):rotationy(180):zoom(0):diffusealpha(0):accelerate(0.8):addx(-200):zoom(0.8):diffusealpha(0.3):sleep(0):zoom(0)
		end;
	};
	-- bottom right
	LoadActor("ScreenTitleMenu underlay/".. image .."_flybottom") .. {
		InitCommand=function(self)
			self:diffusealpha(0)
		end;
		OnCommand=function(self)
			self:diffuse(dc1):zoom(0):diffusealpha(0):accelerate(0.8):addx(200):zoom(1.5):diffusealpha(0.4):sleep(0):zoom(0)
		end;
	};
	
	LoadActor("ScreenTitleMenu underlay/".. image .."_flybottom") .. {
		InitCommand=function(self)
			self:diffusealpha(0)
		end;
		OnCommand=function(self)
			self:diffuse(dc2):zoom(0):diffusealpha(0):accelerate(0.8):addx(200):zoom(0.8):diffusealpha(0.2):sleep(0):zoom(0)
		end;
	};		
}

--up 150, out 280
t[#t+1] = Def.ActorFrame {
	InitCommand=function(self)
		self:diffusealpha(0)
	end;
	OnCommand=function(self)
		self:x(_screen.cx):y(_screen.cy+200):diffusealpha(1):decelerate(0.4):addy(-150):accelerate(0.5):addy(100):diffusealpha(0)
	end;
		
	--bottom left
	LoadActor("ScreenTitleMenu underlay/".. image .."_flybottom") .. {
		InitCommand=function(self)
			self:diffusealpha(0)
		end;
		OnCommand=function(self)
			self:diffuse(dc1):rotationy(180):zoom(0):diffusealpha(0):accelerate(0.8):addx(-280):zoom(1.2):diffusealpha(0.3):sleep(0):zoom(0)
		end;
	};
	
	--bottom right
	LoadActor("ScreenTitleMenu underlay/".. image .."_flybottom") .. {
		InitCommand=function(self)
			self:diffusealpha(0)
		end;
		OnCommand=function(self)
			self:diffuse(dc1):zoom(0):diffusealpha(0):accelerate(0.8):addx(280):zoom(1.2):diffusealpha(0.2):sleep(0):zoom(0)
		end;
	};
}

--up 250, out 280
t[#t+1] = Def.ActorFrame {

	InitCommand=function(self)
		self:diffusealpha(0)
	end;
	OnCommand=function(self)
		self:x(_screen.cx):y(_screen.cy+200):diffusealpha(1):decelerate(0.4):addy(-250):accelerate(0.5):addy(100):diffusealpha(0)
	end;
	
	--bottom left
	LoadActor("ScreenTitleMenu underlay/".. image .."_flybottom") .. {
		InitCommand=function(self)
			self:diffusealpha(0)
		end;
		OnCommand=function(self)
			self:diffuse(dc1):rotationy(180):zoom(0):diffusealpha(0):accelerate(0.8):addx(-280):zoom(0.2):diffusealpha(0.3):sleep(0):zoom(0)
		end;
	};
	--bottom right
	LoadActor("ScreenTitleMenu underlay/".. image .."_flybottom") .. {
		InitCommand=function(self)
			self:diffusealpha(0)
		end;
		OnCommand=function(self)
			self:diffuse(dc1):zoom(0):diffusealpha(0):accelerate(0.8):addx(280):zoom(0.2):diffusealpha(0.2):sleep(0):zoom(0)
		end;
	};
}

return t;