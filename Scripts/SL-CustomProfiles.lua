local path = THEME:GetThemeDisplayName() .. " UserPrefs.ini"

-- Hook called during profile load
function LoadProfileCustom(profile, dir)
	local fullFilename = dir .. path
	local pn

	-- we've been passed a profile object as the variable "profile"
	-- see if it matches against anything returned by PROFILEMAN:GetProfile(player)
	for player in ivalues(GAMESTATE:GetHumanPlayers()) do
		if profile == PROFILEMAN:GetProfile(player) then
			pn = ToEnumShortString(player)
			break
		end
	end

	if pn and FILEMAN:DoesFileExist(fullFilename) then
		SL[pn].ActiveModifiers = IniFile.ReadFile(fullFilename)["Simply Love"]
	end

	return true
end

-- Hook called during profile save
function SaveProfileCustom(profile, dir)
	local fullFilename = dir .. path

	for player in ivalues(GAMESTATE:GetHumanPlayers()) do
		if profile == PROFILEMAN:GetProfile(player) then
			local pn = ToEnumShortString(player)
			IniFile.WriteFile(fullFilename, {["Simply Love"] = SL[pn].ActiveModifiers})
			break
		end
	end

	return true
end

if SL.IsEtterna then
	function SaveProfileCustomEtterna()
		local p = PROFILEMAN:GetProfile(PLAYER_1)
		local fullFilename = "/Save/" .. path
		IniFile.WriteFile(fullFilename, {["Simply Love"] = SL[ToEnumShortString(PLAYER_1)].ActiveModifiers})
	end

	function LoadProfileCustomEtterna()
		local p = PROFILEMAN:GetProfile(PLAYER_1)
		local fullFilename = "/Save/" .. path
		SL[ToEnumShortString(PLAYER_1)].ActiveModifiers = IniFile.ReadFile(fullFilename)["Simply Love"]
	end
	function LoadProfileCustom(profile, dir)
	end
end
