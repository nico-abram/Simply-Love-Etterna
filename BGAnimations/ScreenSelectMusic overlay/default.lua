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
	local searchHeight = 0.3
	local searchX = 0.5
	local searchY = 0.7
	local mWheel = nil
	local textbox =
		Widg.TextBox {
		onValueChange = function(txbx, str)
			if mWheel then
				mWheel:SongSearch(str)
			end
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
		inputStartCondition = function()
			return searchActor:GetVisible()
		end,
		x = _screen.cx * searchX,
		halign = 1,
		valign = 0.5,
		y = _screen.cy * searchY - 5,
		width = _screen.w * searchWidth - 3,
		height = 40,
		font = {
			scale = 2,
			name = "_wendy small",
			color = color("#FFFFFF"),
			padding = {
				x = 10,
				y = 10
			}
		}
	}
	local searchDef =
		Def.ActorFrame {
		BeginCommand = function(self)
			self:draworder(1):visible(false)
			mWheel = SCREENMAN:GetTopScreen():GetMusicWheel()
			searchActor = self
			SCREENMAN:GetTopScreen():AddInputCallback(
				function(event)
					if event.type == "InputEventType_FirstPress" then
						local key = event.DeviceInput.button:match("DeviceButton_(.+)")
						if key == "f" and INPUTFILTER:IsShiftPressed() then
							local active = not searchActor:GetVisible()
							searchActor:visible(active)
							if not active then
								textbox:EndInput()
							end
						end
					end
				end
			)
		end,
		Def.Quad {
			InitCommand = function(self)
				self:FullScreen():diffuse(color("0,0,0,0")):diffusealpha(0.8):basezoomx(0.5):halign(1)
			end
		},
		-- Intructions BG
		Def.Quad {
			InitCommand = function(self)
				self:xy(_screen.cx * searchX, _screen.cy * searchY - 40):zoomto(_screen.w * searchWidth, _screen.cy * searchHeight):diffuse(
					GetCurrentColor()
				)
			end
		},
		-- white border
		Border(_screen.w * searchWidth, _screen.cy * searchHeight, 2) ..
			{
				InitCommand = function(self)
					self:xy(_screen.cx * searchX, _screen.cy * searchY - 40)
				end
			},
		-- Text Entry BG
		Def.Quad {
			InitCommand = function(self)
				self:xy(_screen.cx * searchX, _screen.cy * searchY + 16):zoomto(_screen.w * searchWidth, 40):diffuse(
					color("#000000")
				)
			end
		},
		-- white border
		Border(_screen.w * searchWidth, 40, 2) ..
			{
				InitCommand = function(self)
					self:xy(_screen.cx * searchX, _screen.cy * searchY + 16)
				end
			},
		textbox
	}
	t[#t + 1] = searchDef
end
return t
