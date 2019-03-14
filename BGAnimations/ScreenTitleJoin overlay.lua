return Def.ActorFrame{
	InitCommand=function(self)
		self:playcommand("Refresh")
	end,
	OnCommand=function(self)
		self:diffuseblink():effectperiod(1):effectcolor1(1,1,1,0):effectcolor2(1,1,1,1)
	end,
	OffCommand=function(self)
		self:visible(false)
	end,
	CoinsChangedMessageCommand=function(self)
		self:playcommand("Refresh")
	end,
	RefreshCommand=function(self)
		if GAMESTATE:GetCoinMode() == "CoinMode_Pay" then
			local Credits = GetCredits()
			if Credits["Credits"] < 1 then
				self:visible(false)
			else
				self:visible(true)
			end
		end
	end,

	LoadFont("_wendy small")..{
		Text=THEME:GetString("ScreenTitleJoin", "Press Start"),
		InitCommand=function(self)
			self:xy(_screen.cx, _screen.h-80):shadowlength(1):valign(0.5)
		end,
		OnCommand=function(self)
			self:zoom(0.7)
		end,
	}
}
