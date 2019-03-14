local optionrow_mt = {
	__index = {
		create_actors = function(self, name)
			self.name=name

			-- this is a terrible way to do this
			local item_index = name:gsub("item", "")
			self.index = item_index

			local af = Def.ActorFrame{
				Name=name,
				InitCommand=function(subself)
					self.container = subself
					subself:diffusealpha(0):queuecommand("Hide2")
				end,
				OnCommand=function(self)
					self:y(item_index * 62)
				end,

				HideCommand=function(self)
					self:linear(0.2):diffusealpha(0):queuecommand("Hide2")
				end,
				Hide2Command=function(subself) subself:visible(false) end,
				UnhideCommand=function(subself) subself:visible(true):queuecommand("Unhide2") end,
				Unhide2Command=function(self)
					self:sleep(0.3):linear(0.2):diffusealpha(1)
				end,


				-- helptext
				Def.BitmapText{
					Font="_miso",
					InitCommand=function(subself)
						self.helptext = subself
						subself:horizalign(left):zoom(0.9)
							:diffuse(Color.White):diffusealpha(0.5)
					end,
					GainFocusCommand=function(self)
						self:diffusealpha(0.85)
					end,
					LoseFocusCommand=function(self)
						self:diffusealpha(0.5)
					end
				},

				-- bg quad
				Def.Quad{
					InitCommand=function(subself)
						self.bgQuad = subself
						subself:horizalign(left):zoomto(200, 28):diffuse(Color.White):diffusealpha(0.5)
					end,
					OnCommand=function(self)
						self:y(26)
					end,
					GainFocusCommand=function(self)
						self:diffusealpha(1)
					end,
					LoseFocusCommand=function(self)
						self:diffusealpha(0.5)
					end,
				},

				Def.ActorFrame{
					Name="Cursor",
					InitCommand=function(subself) self.cursor = subself end,
					OnCommand=function(self) self:y(26) end,
					LoseFocusCommand=function(self)
						self:diffusealpha(0)
					end,
					GainFocusCommand=function(self)
						self:diffusealpha(1)
					end,

					-- right arrow
					Def.ActorFrame{
						Name="RightArrow",
						OnCommand=function(self)
							self:x(216)
						end,
						PressCommand=function(self)
							self:decelerate(0.05):zoom(0.7):glow(color("#ffffff22")):accelerate(0.05):zoom(1):glow(color("#ffffff00"))
						end,
						ExitRowCommand=function(subself, params)
							subself:y(-15)
							if params.PlayerNumber == PLAYER_2 then subself:x(20) end
						end,
						SingleSongCanceledMessageCommand=function(self)
							self:rotationz(0)
						end,
						BothPlayersAreReadyMessageCommand=function(self)
							self:finishtweening():sleep(0.2):linear(0.2):rotationz(180)
						end,
						CancelBothPlayersAreReadyMessageCommand=function(self)
							self:rotationz(0)
						end,

						LoadActor("./img/arrow_glow.png")..{
							Name="RightArrowGlow",
							InitCommand=function(self)
								self:zoom(0.15)
							end,
							OnCommand=function(subself)
								subself:diffuseshift():effectcolor1(1,1,1,0):effectcolor2(1,1,1,1)
							end
						},
						LoadActor("./img/arrow.png")..{
							Name="RightArrow",
							InitCommand=function(self)
								self:zoom(0.15):diffuse(Color.White)
							end,
						}
					},

					-- left arrow
					Def.ActorFrame{
						Name="LeftArrow",
						OnCommand=function(self)
							self:x(-16)
						end,
						PressCommand=function(self)
							self:decelerate(0.05):zoom(0.7):glow(color("#ffffff22")):accelerate(0.05):zoom(1):glow(color("#ffffff00"))
						end,
						ExitRowCommand=function(subself, params)
							subself:y(-15)
							if params.PlayerNumber == PLAYER_1 then subself:x(180) end
						end,
						SingleSongCanceledMessageCommand=function(self)
							self:rotationz(0)
						end,
						BothPlayersAreReadyMessageCommand=function(self)
							self:finishtweening():sleep(0.2):linear(0.2):rotationz(180)
						end,
						CancelBothPlayersAreReadyMessageCommand=function(self)
							self:rotationz(0)
						end,

						LoadActor("./img/arrow_glow.png")..{
							Name="LeftArrowGlow",
							InitCommand=function(self)
								self:zoom(0.15):rotationz(180)
							end,
							OnCommand=function(subself)
								subself:diffuseshift():effectcolor1(1,1,1,0):effectcolor2(1,1,1,1)
							end
						},
						LoadActor("./img/arrow.png")..{
							Name="LeftArrow",
							InitCommand=function(self)
								self:zoom(0.15):diffuse(Color.White):rotationz(180)
							end,

						}
					}
				}
			}

			return af
		end,

		transform = function(self, item_index, num_items, has_focus)

			self.container:finishtweening()

			if has_focus then
				self.container:playcommand("GainFocus")
			else
				self.container:playcommand("LoseFocus")
			end
		end,

		set = function(self, optionrow)
			if not optionrow then return end
			self.helptext:settext( optionrow.helptext )
			if optionrow.helptext == "" then
				self.bgQuad:visible(false)
			end
		end
	}
}

return optionrow_mt