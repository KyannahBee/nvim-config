-- Runtime settings: builds the final values table from the schema defaults
-- merged with per-user overrides in lua/config/local.json (gitignored, written
-- by the settings menu). Plugin files read values from here:
--   local settings = require("config.settings")
--   settings.values.harness.command
--   settings.get("theme.flavour")
local schema = require("config.schema")

local M = {
    entries = schema, -- re-exported for the settings menu
    values = {},
}

local function split_path(path)
    local parts = {}
    for part in string.gmatch(path, "[^%.]+") do
        parts[#parts + 1] = part
    end
    return parts
end

local function set_path(t, path, value)
    local parts = split_path(path)
    local node = t
    for i = 1, #parts - 1 do
        if type(node[parts[i]]) ~= "table" then
            node[parts[i]] = {}
        end
        node = node[parts[i]]
    end
    node[parts[#parts]] = value
end

local function get_path(t, path)
    local node = t
    for _, part in ipairs(split_path(path)) do
        if type(node) ~= "table" then
            return nil
        end
        node = node[part]
    end
    return node
end

-- 1. Defaults from the schema (skip read-only "display" entries)
local defaults = {}
for _, entry in ipairs(schema) do
    if entry.type ~= "display" then
        set_path(defaults, entry.key, entry.default)
    end
end

-- 2. Per-user overrides from lua/config/local.json, if it exists
local overrides = {}
local local_path = vim.fn.stdpath("config") .. "/lua/config/local.json"
if vim.uv.fs_stat(local_path) then
    local ok, decoded = pcall(vim.json.decode, table.concat(vim.fn.readfile(local_path), "\n"))
    if ok and type(decoded) == "table" then
        overrides = decoded
    else
        vim.notify("config: could not parse " .. local_path .. ", using defaults", vim.log.levels.WARN)
    end
end

-- 3. Merge: overrides win over defaults
M.values = vim.tbl_deep_extend("force", defaults, overrides)

---Get a single setting value by dot-path, e.g. settings.get("harness.command")
function M.get(key)
    return get_path(M.values, key)
end

return M
