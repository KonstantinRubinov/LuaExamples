local myTable = {}

function getFromTable(key)
    if myTable[key] then
        return (key, myTable[key][1],  myTable[key][2])
    else
        return nil
    end
end


function addToTable(key, count, size)
    if myTable[key] then
        myTable[key][1] = myTable[key][1] + count
        myTable[key][2] = myTable[key][2] + size
    else
        myTable[key] = {count, size}
    end
end

function updateTable(key, count, size)
    myTable[key][1] = count
    myTable[key][2] = size
end

function removeFromTable(key)
   myTable[key] = nil
end

function printTable(t)
    for key,value in pairs(t) do 
        print(key, value[1], value[2])
    end
end

//---------------------------------------------------------------------------------------------------------------------------------------------------------//

local peopleTable = {}

function getFromPeopleTable(key)
    if peopleTable[key] then
        return (peopleTable[key])
    else
        return nil
    end
end

function addToPeopleFrom(key, from)
    peopleTable[key][2] = from
end

function addToPeopleTo(key, to)
    peopleTable[key][3] = to
	peopleTable[key][1] = peopleTable[key][1] + peopleTable[key][3]-peopleTable[key][2]
end

function updateToPeopleTable(key, from, to)
     peopleTable[key][2] = from
	 peopleTable[key][3] = to
	 peopleTable[key][1] = peopleTable[key][1] + peopleTable[key][3]-peopleTable[key][2]
end

function removeFromPeopleTable(key)
   peopleTable[key] = nil
end