local t = Def.ActorFrame{}
local game = GAMESTATE:GetCurrentGame():GetName()
local Players = GAMESTATE:GetHumanPlayers()

local Highlights = {
	Start={		x=0, 	y=66, 	rotationz=0, 	zoom=0.5, graphic="highlightgreen.png" },
	Select={	x=0, 	y=95,	rotationz=180, 	zoom=0.5, graphic="highlightred.png" },
	MenuRight={	x=37, 	y=80, 	rotationz=0, 	zoom=0.5, graphic="highlightarrow.png" },
	MenuLeft={	x=-37, 	y=80, 	rotationz=180,	zoom=0.5, graphic="highlightarrow.png" },
	
	UpLeft={	x=-67,	y=-148, rotationz=0,	zoom=0.8, graphic="highlight.png" },	
	Up={		x=0, 	y=-148, rotationz=0,	zoom=0.8, graphic="highlight.png" },
	UpRight={	x=67, 	y=-148, rotationz=0,	zoom=0.8, graphic="highlight.png" },
	
	Left={		x=-67,	y=-80,	rotationz=0,	zoom=0.8, graphic="highlight.png" },
	Center={	x=0, 	y=-80,	rotationz=0,	zoom=0.8, graphic="highlight.png" },
	Right={		x=67, 	y=-80,	rotationz=0,	zoom=0.8, graphic="highlight.png" },

	DownLeft={	x=-67,	y=-12,	rotationz=0,	zoom=0.8, graphic="highlight.png" },	
	Down={		x=0,	y=-12,	rotationz=0,	zoom=0.8, graphic="highlight.png" },
	DownRight={	x=67, 	y=-12,	rotationz=0,	zoom=0.8, graphic="highlight.png" }
}

for pn in ivalues(Players) do
	
 	local PlayerPad = Def.ActorFrame{
		InitCommand=function(self)
			self:diffusealpha(0);
			if pn == PLAYER_1 then
				self:x(_screen.cx-150);
			elseif pn == PLAYER_2 then
				self:x(_screen.cx+150);
			end
			self:y(_screen.cy);
		end;
		OnCommand=function(self)
			self:linear(0.3):diffusealpha(1)
		end;
		OffCommand=function(self)
			self:linear(0.2):diffusealpha(0)
		end;
	
		LoadFont("_wendy small")..{
			Text="PLAYER "..ToEnumShortString(pn):gsub("P","");
			InitCommand=function(self)
				self:y(-210):zoom(0.7)
			end
		};
		LoadActor(game..".png")..{
			InitCommand=function(self)
				self:y(-80):zoom(0.8)
			end;
		};
		LoadActor("buttons.png")..{
			InitCommand=function(self)
				self:y(80):zoom(0.5)
			end;
		};
	}
	
	for panel,values in pairs(Highlights) do
		PlayerPad[#PlayerPad+1] = LoadActor( values.graphic )..{
			InitCommand=function(self)
				self:xy(values.x, values.y):rotationz(values.rotationz):zoom(values.zoom):diffusealpha(0)
			end;
			[ToEnumShortString(pn) .. panel .."OnMessageCommand"]=function(self)
				self:diffusealpha(1)
			end;
			[ToEnumShortString(pn) .. panel .."OffMessageCommand"]=function(self)
				self:diffusealpha(0)
			end;
		}
	end
	
	t[#t+1] = PlayerPad
	
end

return t;