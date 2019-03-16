local polled = false
return Def.ActorFrame {
	InitCommand = function(self)
		self:x(26)
		if SL.IsEtterna then
			self:SetUpdateFunction(
				function()
					polled = false
				end
			):SetUpdateFunctionInterval(0.05)
		end
	end,
	Def.Quad {
		BeginCommand = function(self)
			self:diffuse(color("#000a11")):zoomto(_screen.w / 2.1675, _screen.h / 15):diffusealpha(0.5)
			self.top = SCREENMAN:GetTopScreen()
			self.wheel = self.top:GetMusicWheel()
		end,
		LeftClickMessageCommand = SL.IsEtterna and
			function(self)
				local mouse = getMousePosition()
				local mx, my = mouse.x, mouse.y
				if polled then
					return
				end
				local x, y, w, h =
					self:GetTrueX(),
					self:GetTrueY(),
					self:GetWidth() * self:GetZoomX(),
					self:GetHeight() * self:GetZoomY()
				local b = mx > x - w / 2 and my > y - h / 2 and mx < x + w / 2 and my < y + h / 2
				if b then
					polled = true
					local n = math.floor(my / h) - 7
					local doot = self.wheel:MoveAndCheckType(n)
					self.wheel:Move(0)
					if n == 0 or doot == "WheelItemDataType_Section" then
						self.top:SelectCurrent(0)
					end
				end
			end or
			nil
	},
	Def.Quad {
		InitCommand = function(self)
			self:diffuse(ThemePrefs.Get("RainbowMode") and Color.White or color("#0a141b")):diffusealpha(
				ThemePrefs.Get("RainbowMode") and 0.5 or 1
			):zoomto(_screen.w / 2.1675, _screen.h / 15 - 1)
		end
	}
}
