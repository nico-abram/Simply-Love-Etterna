-- this is only used for the Screen that manages local profiles so far

local NumRows

local t = Def.ActorFrame {
	InitCommand=function(self)
		self:xy(_screen.cx-_screen.w/6, -16):queuecommand("Capture")
	end,
	CaptureCommand=function(self)
		-- how many rows do we need to accommodate?
		NumRows = #SCREENMAN:GetTopScreen():GetChild("Container"):GetChild("")
		-- If there are more than 10 rows, they collapse into a scroller anyway,
		-- so limit it to 10 if so.
		if NumRows > 10 then NumRows = 10 end
		self:queuecommand("Size")
	end,


	-- white border
	Def.Quad{
		SizeCommand=function(self)
			self:zoomto(240, 28*NumRows)
		end
	},

	LoadFont("_miso")..{
		InitCommand=function(self)
			self:xy(-80, -118):halign(0):diffuse(Color.Black)
		end,
		BeginCommand=function(self)
			local profile = GAMESTATE:GetEditLocalProfile()
			if profile then
				self:settext(profile:GetDisplayName())
			end
		end
	}
}

return t