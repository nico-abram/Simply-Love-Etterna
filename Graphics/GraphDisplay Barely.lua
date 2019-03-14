return Def.ActorFrame {
	InitCommand = function(self)
		self:diffusealpha(0)
	end,
	OnCommand = function(self)
		self:y(-20):sleep(2):accelerate(0.2):diffusealpha(1):y(10):decelerate(0.2):y(-5):accelerate(0.2):y(10)
	end,
	Def.BitmapText {
		Font = "_miso",
		Text = THEME:GetString("GraphDisplay", "Barely"),
		InitCommand = function(self)
			self:zoom(0.75)
		end
	},
	Def.Sprite {
		Texture = THEME:GetPathB("ScreenSelectMusic", "overlay/PerPlayer/arrow.png"),
		InitCommand = function(self)
			self:rotationz(90):zoom(0.5):y(10)
		end,
		OnCommand = function(self)
			self:sleep(0.5):diffuseshift():effectcolor1(1, 1, 1, 1):effectcolor2(1, 1, 1, 0.2)
		end
	}
}
