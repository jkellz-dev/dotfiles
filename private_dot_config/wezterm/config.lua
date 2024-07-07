local wezterm = require("wezterm")

---@class Config
---@field options table
local Config = {}
Config.__index = Config

---Initialize Config
---@return Config
function Config:init()
	local config = setmetatable({ options = {} }, self)
	return config
end

-- Function to check if a value is a table
local function isTable(value)
	return type(value) == "table"
end

-- Function to check if a table is an array
local function isArray(t)
	if type(t) ~= "table" then
		return false
	end
	local i = 1
	for _ in pairs(t) do
		if t[i] == nil then
			return false
		end
		i = i + 1
	end
	return true
end

-- Generic merge function that merges t2 into t1 in place
local function mergeTables(t1, t2)
	for k, v in pairs(t2) do
		if isTable(v) and isTable(t1[k]) then
			if isArray(t1[k]) and isArray(v) then
				-- If both tables are arrays concatenate them
				for _, v2 in ipairs(v) do
					table.insert(t1[k], v2)
				end
			else
				-- Otherwise, recursively merge them as dictionaries
				mergeTables(t1[k], v)
			end
		elseif isTable(v) then
			-- If t1[k] is not a table, initialize it as an empty table
			if not isTable(t1[k]) then
				t1[k] = {}
			end
			mergeTables(t1[k], v)
		else
			t1[k] = v
		end
	end
end

---Append to `Config.options`
---@param new_options table new options to append
---@return Config
function Config:merge(new_options)
	mergeTables(self.options, new_options)
	-- for k, v in pairs(new_options) do
	-- 	if self.options[k] ~= nil then
	-- 		if k == "keys" then
	-- 			mergeTables(self.options[k], v)
	-- 		else
	-- 			wezterm.log_warn("Duplicate config option detected: ", { old = self.options[k], new = new_options[k] })
	-- 		end
	-- 	else
	-- 		self.options[k] = v
	-- 	end
	-- end
	return self
end

return Config
