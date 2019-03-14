local t =
	Def.ActorFrame {
	InitCommand = function(self)
		self:draworder(1)
	end
}

local players = SL.IsEtterna and {PLAYER_1} or {PLAYER_1, PLAYER_2}
for player in ivalues(players) do
	-- StepArtist Box
	t[#t + 1] = LoadActor("./StepArtist.lua", player)

	-- bouncing Cursor inside the Grid of difficulty blocks
	t[#t + 1] = LoadActor("./Cursor.lua", player)

	-- Step Data (Number of steps, jumps, holds, etc.)
	t[#t + 1] = LoadActor("./PaneDisplay.lua", player)

	-- Density Graph
	t[#t + 1] = LoadActor("./DensityGraph.lua", player)
end

return t
