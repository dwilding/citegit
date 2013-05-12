--- Returns the output of a command.
-- Restricted to git commands only (using a naive method).
-- @param cmd The command to run.
local function runcommand(cmd)
	-- Check cmd is a git command.
	-- if (string.find(cmd, 'git ') ~= 1) then
  	-- return 'Something bad happened! (Maybe throw an exception?)'
	-- end
  
	-- Run the command
	local f = assert(io.popen(cmd, 'r'))
	local s = assert(f:read('*a'))
	f:close()

	-- Clean the output.
	s = string.gsub(s, '\\([@a-z]*)', '\\macro{%1}')
	if raw then return s end
	s = string.gsub(s, '^%s+', '')
	s = string.gsub(s, '%s+$', '')
	s = string.gsub(s, '[\n\r]+', ' ')
	return s
end

--- Returns the output of a git command with a list of dependencies.
-- @param git The git command to run (in a table).
-- @param deps Table of dependencies.
local function gitcommand(git, deps)
  -- Build the command we want to execute.
  for k, v in ipairs(deps) do table.insert(git, v) end
  return runcommand(table.concat(git, " "))
end

--- Runs git log.
-- @param flag The information to return. Can take any of the placeholder 
-- values or something more complicated as in the git-log documentation.
-- @param deps Table of dependencies.
local function gitinfo(flag, deps)
	return gitcommand({'git log -1 --format="%', flag, '" --'}, deps)
end

-- Print the output of git log in the (La)TeX document.
-- @param flag The information to return. Can take any of the placeholder 
-- values or something more complicated as in the git-log documentation.
-- @param deps Table of dependencies.
function printGitinfo(flag, deps)
	tex.sprint(gitinfo(flag, deps))
end

--- Returns the status of the git repository.
-- @param untracked Include untracked files (true) or not (false).
-- @param deps Table of dependencies.
local function gitstatus(untracked, deps)
	ut = '=no'
	if untracked then
		ut = ''
	end

	return gitcommand(
		{'git status --porcelain --untracked-files' .. ut .. ' -- '},
		deps)
end

--- Print the status of the git repository.
-- @param untracked Include untracked files (true) or not (false).
-- @param deps Table of dependencies.
function printGitstatus(untracked, deps)
	tex.sprint(gitstatus(untracked, deps))
end

--- Returns the status of the git repository as a Boolean.
-- Returns true if the repository has not been modified.
-- @param untracked Include untracked files (true) or not (false).
-- @param deps Table of dependencies.
function gitClean(untracked, deps)
  status = gitstatus(untracked, deps)
  if status == '' then
    return true
  else
    return false
  end
end

--- Finds the GitHub repository.
function github()
	gh = runcommand('git remote -v')
	gh = string.gsub(gh, '.*git@github.com:(.*)\.git.*', '%1')
	return gh
end

--- Prints the GitHub repository.
function printGithub()
	tex.sprint(github())
end

--- Broken.
function gitpath(dir, file)
	repo = runcommand('readlink -mn "$(git rev-parse --show-toplevel)"')
	path = runcommand('cd ' .. dir .. '; readlink -mn ' .. file)
	s = path .. '\#' .. repo
	return s
end

function printGitpath(dir, file)
	tex.sprint(gitpath(dir, file))
end

