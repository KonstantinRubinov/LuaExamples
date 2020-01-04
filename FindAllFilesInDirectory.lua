--Lua tutorial https://www.tutorialspoint.com/lua/lua_file_io.htm

--http://www.wellho.net/resources/ex.php4?item=u112/dlisting

function scandir(dirname)
        callit = os.tmpname()
        os.execute("ls -a1 "..dirname .. " >"..callit)
        f = io.open(callit,"r")
        rv = f:read("*all")
        f:close()
        os.remove(callit)

        tabby = {}
        local from  = 1
        local delim_from, delim_to = string.find( rv, "\n", from  )
        while delim_from do
                table.insert( tabby, string.sub( rv, from , delim_from-1 ) )
                from  = delim_to + 1
                delim_from, delim_to = string.find( rv, "\n", from  )
                end
        -- table.insert( tabby, string.sub( rv, from  ) )
        -- Comment out eliminates blank line on end!
        return tabby
        end

filetab = scandir(".")

print ("Directory contents")
for n,v in ipairs(filetab) do
        print (n,v)
        end

--[[ -------------------------------- sample output --------------
[trainee@easterton u112]$ lua dlisting
Directory contents
1       .
2       ..
3       dlisting
4       globals
5       timtimer
[trainee@easterton u112]$
]]

//-----------------------------------------------------------------------------------------------------------------//



require 'paths'
require 'lfs'

fpaths = {}

function isdir(path)
  return lfs.attributes(path)["mode"] == "directory"
end

function listfiles(dir)
  local files = paths.dir(dir)
  for i=1,#files do
    if files[i] ~= '.' and files[i] ~= '..' then
      next_dir = dir..'/'..files[i]
      if isdir(next_dir) then
        listfiles(next_dir)
      else
        table.insert(fpaths,files[i])
      end
    end
  end
  return fpaths
end