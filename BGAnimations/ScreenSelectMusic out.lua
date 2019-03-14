return Def.ActorFrame {
	InitCommand = function(self)
		self:draworder(200)
	end,
	Def.Quad {
		InitCommand = function(self)
			self:diffuse(Color.Black):FullScreen():diffusealpha(0)
		end,
		OffCommand = function(self)
			self:cropbottom(1):fadebottom(.5):linear(0.3):cropbottom(-0.5):diffusealpha(1)
		end
	},
	LoadFont("_wendy small") ..
		{
			Text = THEME:GetString("ScreenSelectMusic", "Press Start for Options"),
			InitCommand = function(self)
				self:Center():zoom(0.75)
			end,
			OnCommand = function(self)
				self:visible(false)
			end,
			ShowPressStartForOptionsCommand = function(self)
				self:visible(true)
			end,
			ShowEnteringOptionsCommand = function(self)
				self:linear(0.125):diffusealpha(0):queuecommand("NewText")
			end,
			NewTextCommand = function(self)
				if not SL.IsEtterna then
					self:hibernate(0.1)
				end
				self:settext(THEME:GetString("ScreenSelectMusic", "Entering Options...")):linear(0.125):diffusealpha(1):hurrytweening(
					0.1
				):sleep(1)
			end
		}
}
