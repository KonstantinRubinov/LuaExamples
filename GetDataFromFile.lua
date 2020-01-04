-- http://lua-users.org/wiki/FileInputOutput

-- see if the file exists
function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

-- get all lines from a file, returns an empty 
-- list/table if the file does not exist
function lines_from(file)
  if not file_exists(file) then return {} end
  lines = {}
  for line in io.lines(file) do 
    lines[#lines + 1] = line
  end
  return lines
end

--OR

function read_file(path)
	local file = io.open(path, "rb") 
	if not file then return nil end
	
	local mylines = {}
	
	for line in io.lines(path) do
		local words = {}
		for word in line:gmatch("%w+") do 
			table.insert(words, word) 
		end    
	table.insert(mylines, words)
	end
	
	file:close()
	return mylines;
end















-- tests the functions above
local file = 'test.lua'
local lines = lines_from(file)
local lines = read_file(file)

-- print all line numbers and their contents
for k,v in pairs(lines) do
  print('line[' .. k .. ']', v)
end