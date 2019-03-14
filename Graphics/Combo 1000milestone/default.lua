local image = ThemePrefs.Get("VisualTheme")

return Def.ActorFrame{

	LoadActor("../Combo 100milestone"),

	LoadActor(image.."_swoosh.png")..{
		InitCommand=function(self)
			self:diffusealpha(0):blend("BlendMode_Add")
		end,
		MilestoneCommand=function(self)
			self:finishtweening():diffuse(GetCurrentColor()):zoom(0.25):diffusealpha(0.7):x(0):linear(0.7):zoom(3):diffusealpha(0):x(100)
		end
	},

	LoadActor(image.."_swoosh.png")..{
		InitCommand=function(self)
			self:diffusealpha(0):blend("BlendMode_Add")
		end,
		MilestoneCommand=function(self)
			self:finishtweening():diffuse(GetCurrentColor()):rotationy(180):zoom(0.25):diffusealpha(0.7):x(0):linear(0.7):zoom(3):diffusealpha(0):x(-100)
		end
	}
}