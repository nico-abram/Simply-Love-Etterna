local t =
	Def.ActorFrame {
	ChangeStepsMessageCommand = function(self, params)
		self:playcommand("StepsHaveChanged", {Direction = params.Direction, Player = params.Player})
	end,
	StorageDevicesChangedMessageCommand = function(self)
		SCREENMAN:SetNewScreen("ScreenProfileLoad")
	end,
	-- make the MusicWheel appear to cascade down
	LoadActor("./MusicWheelAnimation.lua"),
	-- Apply player modifiers from profile
	LoadActor("./PlayerModifiers.lua"),
	-- Difficulty Blocks (normal) or CourseContentsList (CourseMode)
	LoadActor("./StepsDisplayList/default.lua"),
	-- Graphical Banner
	LoadActor("./Banner.lua"),
	-- Song Artist, BPM, Duration (Referred to in other themes as "PaneDisplay")
	LoadActor("./SongDescription.lua"),
	-- a folder of Lua files to be loaded twice (once for each player)
	LoadActor("./PerPlayer/default.lua"),
	-- MenuTimer code for preserving SSM's timer value
	LoadActor("./MenuTimer.lua"),
	-- overlay for sorting the MusicWheel, hidden by default
	LoadActor("./SortMenu/default.lua")
}
if SL.IsEtterna then
	local searchActor
	local searchWidth = 0.45
	local searchHeight = 25
	local searchX = 0.5
	local searchY = 0.18
	local mWheel = nil
	local tooltipActor
	local coverQuadActor
	local font = "_wendy small"
	local fontScale = 0.3
	local textbox =
		Widg.TextBox {
		onValueChange = function(txbx, str)
			if mWheel then
				coverQuadActor:visible(true)
				mWheel:SongSearch(str)
				tooltipActor:visible(str == "")
			end
		end,
		onValueChangeEnd = function(txbx, str)
			coverQuadActor:visible(false)
		end,
		bgColor = color("#000000"),
		border = {
			color = color("#888888"),
			width = 0
		},
		highlight = {
			color = color("#333333"),
			alpha = false
		},
		x = _screen.cx * searchX,
		y = _screen.cy * searchY - 5,
		halign = 1,
		valign = 0.5,
		width = _screen.w * searchWidth - 3,
		height = searchHeight,
		font = {
			scale = fontScale,
			name = font,
			color = color("#FFFFFF"),
			padding = {
				x = 10,
				y = 10
			}
		},
		clearOnEsc = true
	}
	local searchDef =
		Def.ActorFrame {
		BeginCommand = function(self)
			self:draworder(1)
			local top = SCREENMAN:GetTopScreen()
			mWheel = top:GetMusicWheel()
			searchActor = self
			top:AddInputCallback(
				function(event)
					if event.type == "InputEventType_FirstPress" then
						if event.DeviceInput.button == "DeviceButton_mousewheel up" then
							self.moving = true
							if pressingtab == true and not mWheel:IsSettled() then
								mWheel:Move(-2)
							else
								mWheel:Move(-1)
							end
							mWheel:Move(0)
						elseif event.DeviceInput.button == "DeviceButton_mousewheel down" then
							self.moving = true
							if pressingtab == true and not mWheel:IsSettled() then
								mWheel:Move(2)
							else
								mWheel:Move(1)
							end
							mWheel:Move(0)
						end
					elseif self.moving == true then
						mWheel:Move(0)
						self.moving = false
					elseif event.type == "InputEventType_Release" then
						local key = event.DeviceInput.button:match("DeviceButton_(.+)")
						if key == "f" and INPUTFILTER:IsShiftPressed() then
							local active = not coverQuadActor:GetVisible()
							coverQuadActor:visible(active)
							if not active then
								textbox:EndInput()
							else
								textbox:StartInput()
							end
						end
					end
				end
			)
		end,
		Def.Quad {
			InitCommand = function(self)
				coverQuadActor = self
				self:visible(false):FullScreen():diffuse(color("0,0,0,0")):diffusealpha(0.8):basezoomx(0.5):halign(1)
			end
		},
		-- Text Entry BG
		Def.Quad {
			InitCommand = function(self)
				self:xy(_screen.cx * searchX, _screen.cy * searchY + 16):zoomto(_screen.w * searchWidth, searchHeight):diffuse(
					color("#000000")
				)
			end
		},
		-- white border
		Border(_screen.w * searchWidth, searchHeight + 5, 2) ..
			{
				InitCommand = function(self)
					self:xy(_screen.cx * searchX, _screen.cy * searchY + 8)
				end
			},
		textbox,
		LoadFont(font) ..
			{
				InitCommand = function(self)
					tooltipActor = self
					self:x(_screen.cx * searchX):y(_screen.cy * searchY + searchHeight / 2 - 5):diffusealpha(0.5):settext(
						"Press shift+f to start searching"
					):zoom(fontScale)
				end
			}
	}
	t[#t + 1] = searchDef
end
return t
