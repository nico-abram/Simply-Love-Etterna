-- only needed in etterna
if not GAMESTATE.GetEtternaVersion then
	return
end

--[[ 
    Hook ourselves into LogDisplay
    This is a uper ugly hack to execute code once singletons are finished getting created
    to use another ugly hack to add lua functions to a singleton as methods
--]]
--[[
	thing: userdata or table
]]
local function addIdxMt(thing, _index)
	local mt = debug.getmetatable(thing)
	local f = mt.__index
	if type(f) == "table" then
		mt.__index = function(t, k)
			return f[k] or _index[k]
		end
	else
		mt.__index = function(t, k)
			--[[
			if SCREENMAN and SCREENMAN.SystemMessage then
				SCREENMAN:SystemMessage(k)
			end
			--]]
			return f(t, k) or _index[k]
		end
	end
end
local function addIdxMtPrioritizing(thing, _index)
	local mt = debug.getmetatable(thing)
	local f = mt.__index
	if type(f) == "table" then
		mt.__index = function(t, k)
			return _index[k] or f[k]
		end
	else
		mt.__index = function(t, k)
			--[[
			if SCREENMAN and SCREENMAN.SystemMessage then
				SCREENMAN:SystemMessage(k)
			end
			--]]
			return _index[k] or f(t, k)
		end
	end
end
do
	local original = Def.LogDisplay
	Def.LogDisplay = function(...)
		local x = original(...)
		return Def.ActorFrame {
			x,
			InitCommand = function()
				local removedPrefs = {
					["AutogenGroupCourses"] = false,
					["SongsPerPlay"] = 1000,
					["HarshHotLifePenalty"] = 0,
					["Premium"] = "On",
					["MaxHighScoresPerListForMachine"] = 5
				}
				local setpref = PREFSMAN.SetPreference
				local getpref = PREFSMAN.GetPreference
				addIdxMtPrioritizing(
					PREFSMAN,
					{
						GetPreference = function(_, k)
							local v = removedPrefs[k]
							if v ~= nil then
								return v
							else
								return getpref(PREFSMAN, k)
							end
						end,
						SetPreference = function(_, k, v)
							local v = removedPrefs[k]
							if v == nil then
								setpref(PREFSMAN, k, v)
							end
						end
					}
				)
				addIdxMt(
					GAMESTATE,
					{
						IsCourseMode = function()
							return false
						end,
						GetCurrentCourse = function()
							return nil
						end
					}
				)
				addIdxMt(
					SONGMAN,
					{
						GetAllCourses = function()
							return {}
						end
					}
				)
			end
		}
	end
end
MEMCARDMAN = {GetCardState = function(Player)
		return "MemoryCardState_none"
	end}
--- IniFile: basically a Lua rewrite of SM's IniFile class that serves as the
-- basis for the sm-ssc UserPrefs and ThemePrefs configuration systems.
-- Note that this is a namespace, not a class per se.
-- So all it's functions are under IniFile
-- @usage IniFile.ReadFile("config.ini")
-- @module 01_IniFile

-- @todo: move this into a more general section
-- func takes a key and a value
function foreach_by_sorted_keys(tbl, keys, func)
	table.sort(keys)
	for _, key in ipairs(keys) do
		func(key, tbl[key])
	end
end

function foreach_ordered(tbl, func)
	local string_keys = {}
	local number_keys = {}
	-- First person to to use this on a table that uses something else as keys
	-- gets to extend this function to cover more types.  And a beating. -Kyz
	for k, _ in pairs(tbl) do
		if type(k) == "string" then
			table.insert(string_keys, k)
		elseif type(k) == "number" then
			table.insert(number_keys, k)
		end
	end
	-- iterate in sorted order
	foreach_by_sorted_keys(tbl, number_keys, func)
	foreach_by_sorted_keys(tbl, string_keys, func)
end

-- redeclared here for my sanity's sake
-- @todo: declare these as global variables
local RageFile = {
	READ = 1,
	WRITE = 2,
	STREAMED = 4,
	SLOW_FLUSH = 8
}

IniFile = {}

--- Parses an "a=b" expresion string into a pair a,b
-- @string str
-- @treturn string key ini key
-- @treturn number|bool|string key ini value
function IniFile.StrToKeyVals(str)
	local key, value = str:match("(.+)=(.*)")

	-- key is always a string, but value may be num, bool, or nil.
	-- do a few quick checks to see which one it is.

	-- if it's a nil, convert it to an empty string and return
	if value == nil then
		value = ""
		return key, value
	end

	-- if it's a number, convert it in place and return
	if tonumber(value) ~= nil then
		value = tonumber(value)
		return key, value
	end

	-- not a number, so let's try a boolean value
	if value == "true" then
		value = true
	elseif value == "false" then
		value = false
	end

	return key, value
end

--- Read a file as ini
-- @string file_path path to ini file
-- @treturn {section={key=value}} parsedIniFile
function IniFile.ReadFile(file_path)
	Trace("IniFile.ReadFile( " .. file_path .. " )")
	local file = RageFileUtil.CreateRageFile()

	if not file:Open(file_path, RageFile.READ) then
		Warn(string.format("ReadFile(%s): %s", file_path, file:GetError()))
		file:destroy()
		return {} -- return a blank table
	end

	local tbl = {}
	local current = tbl

	while not file:AtEOF() do
		local str = file:GetLine()

		--ignore comments.
		if not str:find("^%s*#") then
			-- is this a section?
			local sec = str:match("%[(.+)%]")

			-- if so, set focus there; otherwise, try to
			-- read a key/value pair (ignore blank lines)
			if sec then
				--Warn( "Switching section to " .. sec )
				-- if this section doesn't exist, create it
				tbl[sec] = tbl[sec] and tbl[sec] or {}
				current = tbl[sec]
			else
				local k, v = IniFile.StrToKeyVals(str)
				if k and v ~= nil then
					current[k] = v
				end
			end
		end
	end

	file:Close()
	file:destroy()

	return tbl
end

--- Read a file as ini
-- @string file_path path to ini file
-- @tparam {section={key=value}} tbl iniFileTable
-- @treturn bool success
function IniFile.WriteFile(file_path, tbl)
	Trace("IniFile.WriteFile( " .. file_path .. " )")
	local file = RageFileUtil.CreateRageFile()

	if not file:Open(file_path, RageFile.WRITE) then
		Warn(string.format("WriteFile(%s): %s", file_path.file:GetError()))
		file:destroy()
		return false
	end

	-- declare functions so we can write with foreach_ordered
	local function put_pair(k, v)
		file:PutLine(string.format("%s=%s", k, tostring(v)))
	end

	local function put_section(section, pair)
		file:PutLine("[" .. section .. "]")
		foreach_ordered(pair, put_pair)
		file:PutLine("") -- put a blank line between sections
	end

	-- each base key is a section and its value is a
	-- table of key-value pairs under that section.
	foreach_ordered(tbl, put_section)

	file:Close()
	file:destroy()
	return true
end
