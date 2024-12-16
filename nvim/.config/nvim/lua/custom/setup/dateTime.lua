local M = {}

-- Function to get good looking date time for obsdian
local function get_beautified_datetime()
	local datetime = os.date("*t")
	local months = { "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" }
	return string.format(
		"%02d-%s-%02d|%s",
		datetime.day,
		months[datetime.month],
		tostring(datetime.year):sub(-2),
		os.date("%a") -- Abbreviated weekday name
	)
end

-- Function to insert beautified datetime at cursor position
local function insert_beautified_datetime()
	local datetime = get_beautified_datetime()
	local pos = vim.api.nvim_win_get_cursor(0)
	local line = vim.api.nvim_get_current_line()
	local new_line = line:sub(1, pos[2]) .. datetime .. line:sub(pos[2] + 1)
	vim.api.nvim_set_current_line(new_line)
	-- Move cursor after inserted datetime
	vim.api.nvim_win_set_cursor(0, { pos[1], pos[2] + #datetime })
end

-- Function to get formatted date and time
local function get_datetime()
	local datetime = os.date("*t")
	return string.format(
		"%04d-%02d-%02dT%02dH-%02dM",
		datetime.year,
		datetime.month,
		datetime.day,
		datetime.hour,
		datetime.min
	)
end

-- Function to insert datetime at cursor position
local function insert_datetime()
	local datetime = get_datetime()
	local pos = vim.api.nvim_win_get_cursor(0)
	local line = vim.api.nvim_get_current_line()
	local new_line = line:sub(1, pos[2]) .. datetime .. line:sub(pos[2] + 1)
	vim.api.nvim_set_current_line(new_line)
	-- Move cursor after inserted datetime
	vim.api.nvim_win_set_cursor(0, { pos[1], pos[2] + #datetime })
end

-- Setup function
function M.setup(opts)
	-- Default options
	opts = opts or {}
	local keymap = opts.keymap or "<leader>dts"

	-- Set up the keymap
	vim.keymap.set("n", keymap, insert_datetime, {
		desc = "Insert datetime at cursor",
		noremap = true,
		silent = true,
	})

	-- Create command
	vim.api.nvim_create_user_command("DateTime", insert_datetime, {})

	local keymap1 = opts.keymap or "<leader>dtb"

	-- Set up the keymap
	vim.keymap.set("n", keymap1, insert_beautified_datetime, {
		desc = "Insert beautified datetime at cursor",
		noremap = true,
		silent = true,
	})

	-- Create command
	vim.api.nvim_create_user_command("BeautifiedDateTime", insert_beautified_datetime, {})
end

return M
