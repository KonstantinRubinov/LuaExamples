--THE EXAM OF KONSTANTIN RUBINOV


--table with id, number of work days and sum of work hours
local timeTable = {}



-- function to add work hours by id
function addTime(key, time)
	if timeTable[key] then
		timeTable[key][1] = timeTable[key][1] + 1
    	timeTable[key][2] = timeTable[key][2]+time
    else
        timeTable[key] = {1, time}
    end
end





-- function to find average work hours by id
function getAverage()
	for k,v in pairs(timeTable) do
  		print(k, SecondsToClock(timeTable[k][2]/timeTable[k][1]))
	end
end





-- convert seconds to normal time
function SecondsToClock(seconds)
  local seconds = tonumber(seconds)

  if seconds <= 0 then
    return "00:00:00";
  else
    hours = string.format("%02.f", math.floor(seconds/3600));
    mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
    secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60));
    return hours..":"..mins..":"..secs
  end
end


-- sign-out nimus sign-in
function getWorkHours(from, to)
	
	local fromInHour, fromInMinute, fromInSecond =  string.match(from, '^(%d%d):(%d%d):(%d%d)')
	local toInHour, toInMinute, toInSecond =  string.match(to, '^(%d%d):(%d%d):(%d%d)')


	if (toInHour=="00") then
			toInHour="24"
	end
	if (toInHour=="01") then
			toInHour="25"
	end
	if (toInHour=="02") then
			toInHour="26"
	end


	local fromTime = os.time({year=0, month=0, day=0, hour=fromInHour, min=fromInMinute, sec=fromInSecond, isdst=false})
	local toTime = os.time({year=0, month=0, day=0, hour=toInHour, min=toInMinute, sec=toInSecond, isdst=false})

	local timeDifference=toTime-fromTime

	return timeDifference
	
end


















--table of workers contains id, number of days, time from, time to
local peopleTable = {}

function addToPeopleFrom(key, from)
	--print(key , from)
	if peopleTable[key] then
    	peopleTable[key][2] = from
    else
        peopleTable[key] = {1, from, "to"}
    end
end

function addToPeopleTo(key, to)
    peopleTable[key][3] = to
    peopleTable[key][1] = peopleTable[key][1] + 1
    local dif = getWorkHours(peopleTable[key][2], peopleTable[key][3])
	addTime(key, dif)
end



-- see if the file exists
function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end


function analise_lines(line)
	tmpTable = {}
	i=0;
  	for token in string.gmatch(line, "[^%s]+") do
  		i=i+1

		if i==2 then
			token = token:sub(1, -2)
			token = string.sub(token, 2)
		end

		tmpTable[i] = token
	end
	if tmpTable[3]=="log-in" then
		addToPeopleFrom(tmpTable[2], tmpTable[1])
	end
	if tmpTable[3]=="log-out" then
		addToPeopleTo(tmpTable[2], tmpTable[1])
	end
end








function lines_from(file)
  	if not file_exists(file) then return {} end
  	lines = {}
  	for line in io.lines(file) do 
		analise_lines(line)
  	end
	getAverage()
end
















local lines = lines_from('log2.log')

