local M = {}

local uv = vim.uv or vim.loop

local data_dir = vim.fn.stdpath("data") .. "/workspaces/"
local registry_file = data_dir .. "registry.json"
local last_file = data_dir .. "last.txt"

------------------------------------------------------------
-- helpers
------------------------------------------------------------
local function ensure_dir()
	if uv.fs_stat(data_dir) == nil then
		uv.fs_mkdir(data_dir, 448)
	end
end

local function read_json(path)
	local file = io.open(path, "r")
	if not file then return {} end
	local content = file:read("*a")
	file:close()
	return vim.fn.json_decode(content) or {}
end

local function write_json(path, data)
	local file = io.open(path, "w")
	if file then
		file:write(vim.fn.json_encode(data))
		file:close()
	end
end

local function cwd()
	return vim.fn.getcwd()
end

------------------------------------------------------------
-- registry (all known projects)
------------------------------------------------------------
function M.get_registry()
	ensure_dir()
	return read_json(registry_file)
end

function M.set_registry(data)
	ensure_dir()
	write_json(registry_file, data)
end

------------------------------------------------------------
-- register project
------------------------------------------------------------
function M.register(path)
	local reg = M.get_registry()
	if not vim.tbl_contains(reg, path) then
		table.insert(reg, path)
		M.set_registry(reg)
	end

	local file = io.open(last_file, "w")
	if file then
		file:write(path)
		file:close()
	end
end

------------------------------------------------------------
-- last workspace
------------------------------------------------------------
function M.last()
	local file = io.open(last_file, "r")
	if file then
		local path = file:read("*l")
		file:close()
		return path
	end
end

------------------------------------------------------------
-- open workspace
------------------------------------------------------------
function M.open(path)
	if vim.fn.isdirectory(path) == 0 then
		return
	end

	vim.cmd("cd " .. path)
	M.register(path)
	require("core.workspace.sessions").load(path)
end

------------------------------------------------------------
-- auto detect git root
------------------------------------------------------------
function M.detect_root()
	local git_dir = vim.fn.finddir(".git", ".;")
	if git_dir ~= "" then
		return vim.fn.fnamemodify(git_dir, ":h")
	end
	return cwd()
end

return M
