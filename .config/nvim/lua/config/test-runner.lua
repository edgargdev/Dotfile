-- Test runner utilities for TypeScript/JavaScript tests
-- Supports Mocha, Jest, and Vitest

local M = {}

-- Find the nearest package.json by walking up the directory tree
local function find_package_json()
	local current_file = vim.fn.expand("%:p")
	local current_dir = vim.fn.fnamemodify(current_file, ":h")

	-- Walk up the directory tree looking for package.json
	while current_dir ~= "/" do
		local package_json_path = current_dir .. "/package.json"
		if vim.fn.filereadable(package_json_path) == 1 then
			return package_json_path
		end
		current_dir = vim.fn.fnamemodify(current_dir, ":h")
	end

	return nil
end

-- Detect the test runner from package.json
local function detect_test_runner()
	local package_json_path = find_package_json()

	if not package_json_path then
		return nil
	end

	local content = vim.fn.readfile(package_json_path)
	local json_str = table.concat(content, "\n")

	local ok, package_data = pcall(vim.fn.json_decode, json_str)
	if not ok then
		return nil
	end

	-- Check for test script
	if package_data.scripts and package_data.scripts.test then
		local test_script = package_data.scripts.test
		if test_script:match("jest") then
			return "jest"
		elseif test_script:match("vitest") then
			return "vitest"
		elseif test_script:match("mocha") then
			return "mocha"
		end
	end

	-- Check devDependencies
	local dev_deps = package_data.devDependencies or {}
	if dev_deps.jest then
		return "jest"
	elseif dev_deps.vitest then
		return "vitest"
	elseif dev_deps.mocha then
		return "mocha"
	end

	return nil
end

-- Get the test runner command
local function get_test_command(runner, file_path, test_name)
	if runner == "jest" then
		if test_name then
			return string.format("npm test -- %s -t '%s'", file_path, test_name)
		else
			return string.format("npm test -- %s", file_path)
		end
	elseif runner == "vitest" then
		if test_name then
			return string.format("npm test -- %s -t '%s'", file_path, test_name)
		else
			return string.format("npm test -- %s", file_path)
		end
	elseif runner == "mocha" then
		if test_name then
			return string.format("npm test -- %s --grep '%s'", file_path, test_name)
		else
			return string.format("npm test -- %s", file_path)
		end
	end

	return nil
end

-- Find the test block containing the cursor
-- Returns the describe/it block name or nil if outside a test block
local function find_test_block_at_cursor()
	local current_line = vim.fn.line(".")
	local bufnr = vim.api.nvim_get_current_buf()

	-- Get all lines in the buffer
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

	-- Track describe/context blocks with their line numbers and nesting level
	local describe_stack = {} -- Stack of {name, line, level}
	local current_it = nil
	local current_it_line = -1
	local brace_level = 0

	-- Parse from top to cursor line
	for i = 1, math.min(current_line, #lines) do
		local line = lines[i]

		-- Count braces to track nesting level
		for char in line:gmatch(".") do
			if char == "{" then
				brace_level = brace_level + 1
			elseif char == "}" then
				brace_level = brace_level - 1
				-- Pop from describe stack if we're closing a block
				if #describe_stack > 0 and describe_stack[#describe_stack].level >= brace_level then
					table.remove(describe_stack)
				end
			end
		end

		-- Match describe blocks
		local describe_match = line:match("describe%s*%(%s*['\"]([^'\"]+)['\"]")
		if describe_match then
			table.insert(describe_stack, { name = describe_match, line = i, level = brace_level })
		end

		-- Match context blocks (Mocha) - treat like describe
		local context_match = line:match("context%s*%(%s*['\"]([^'\"]+)['\"]")
		if context_match then
			table.insert(describe_stack, { name = context_match, line = i, level = brace_level })
		end

		-- Match it/test blocks
		local it_match = line:match("it%s*%(%s*['\"]([^'\"]+)['\"]")
		if not it_match then
			it_match = line:match("test%s*%(%s*['\"]([^'\"]+)['\"]")
		end
		if it_match then
			current_it = it_match
			current_it_line = i
		end
	end

	-- Determine if cursor is inside an it block or just in describe
	-- Look ahead from the it line to find its closing brace
	local in_it_block = false
	if current_it and current_it_line > 0 then
		local it_brace_level = 0
		local found_opening = false
		local it_closing_line = -1
		
		for i = current_it_line, #lines do
			local line = lines[i]
			for char in line:gmatch(".") do
				if char == "{" then
					it_brace_level = it_brace_level + 1
					found_opening = true
				elseif char == "}" then
					it_brace_level = it_brace_level - 1
					if found_opening and it_brace_level == 0 then
						-- Found the closing brace of the it block
						it_closing_line = i
						break
					end
				end
			end
			if it_closing_line > 0 then
				break
			end
		end
		
		-- We're inside the it block if cursor is between the it line and its closing brace
		if it_closing_line > 0 and current_line <= it_closing_line then
			in_it_block = true
		end
	end

	-- Return the most specific block
	if in_it_block then
		return current_it
	elseif #describe_stack > 0 then
		return describe_stack[#describe_stack].name
	end

	return nil
end

-- Get the package root directory (where package.json is located)
local function get_package_root()
	local package_json_path = find_package_json()
	if not package_json_path then
		return nil
	end
	return vim.fn.fnamemodify(package_json_path, ":h")
end

-- Run tests for the current file
function M.run_file_tests()
	local runner = detect_test_runner()
	if not runner then
		vim.notify("Could not detect test runner (Jest, Vitest, or Mocha)", vim.log.levels.WARN)
		return
	end

	local package_root = get_package_root()
	if not package_root then
		vim.notify("Could not find package.json", vim.log.levels.WARN)
		return
	end

	local file_path = vim.fn.expand("%:p")
	local cmd = get_test_command(runner, file_path)

	if not cmd then
		vim.notify("Unsupported test runner: " .. runner, vim.log.levels.WARN)
		return
	end

	vim.notify("Running tests for: " .. vim.fn.expand("%:t"), vim.log.levels.INFO)
	vim.cmd("tabnew | terminal cd " .. package_root .. " && " .. cmd)
	vim.cmd("startinsert")
end

-- Run the test block containing the cursor
function M.run_test_at_cursor()
	local runner = detect_test_runner()
	if not runner then
		vim.notify("Could not detect test runner (Jest, Vitest, or Mocha)", vim.log.levels.WARN)
		return
	end

	local test_name = find_test_block_at_cursor()
	if not test_name then
		vim.notify("Not inside a test block", vim.log.levels.WARN)
		return
	end

	local package_root = get_package_root()
	if not package_root then
		vim.notify("Could not find package.json", vim.log.levels.WARN)
		return
	end

	local file_path = vim.fn.expand("%:p")
	local cmd = get_test_command(runner, file_path, test_name)

	if not cmd then
		vim.notify("Unsupported test runner: " .. runner, vim.log.levels.WARN)
		return
	end

	vim.notify("Running test: " .. test_name, vim.log.levels.INFO)
	vim.cmd("tabnew | terminal cd " .. package_root .. " && " .. cmd)
	vim.cmd("startinsert")
end

return M
