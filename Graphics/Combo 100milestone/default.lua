local image = ThemePrefs.Get("VisualTheme")

return Def.ActorFrame{
	LoadActor("explosion.png")..{
		InitCommand=function(self)
			self:diffusealpha(0):blend("BlendMode_Add")
		end,
		MilestoneCommand=function(self)
			self:finishtweening():rotationz(0):zoom(2):diffusealpha(0.5):linear(0.5):rotationz(90):zoom(1):diffusealpha(0)
		end
	},

	LoadActor("explosion.png")..{
		InitCommand=function(self)
			self:diffusealpha(0):blend("BlendMode_Add")
		end,
		MilestoneCommand=function(self)
			self:finishtweening():rotationz(0):zoom(2):diffusealpha(0.5):linear(0.5):rotationz(-90):zoom(1):diffusealpha(0)
		end
	},

	LoadActor(image.."_splode")..{
		InitCommand=function(self)
			self:diffusealpha(0):blend("BlendMode_Add")
		end,
		MilestoneCommand=function(self)
			self:finishtweening():diffuse(GetCurrentColor()):rotationz(10):zoom(.25):diffusealpha(0.6):decelerate(0.6):rotationz(0):zoom(2):diffusealpha(0)
		end
	},

	LoadActor(image.."_minisplode")..{
		InitCommand=function(self)
			self:diffusealpha(0):blend("BlendMode_Add")
		end,
		MilestoneCommand=function(self)
			self:finishtweening():diffuse(GetCurrentColor()):rotationz(10):zoom(.25):diffusealpha(1):linear(0.4):rotationz(0):zoom(1.8):diffusealpha(0)
		end
	}
}