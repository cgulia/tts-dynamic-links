function onload()
    localVersion = 1.01
    prettyPrint("v[2fff91]" .. localVersion .. "[-]")
    prettyPrint("Please read the usage instruction on the Github/Workshop.")
    lmAssets = {}
    objectCache = {}
    objectIndex = 0
    self.addContextMenuItem("parseobjects", parseObjects)
end

--function getVersion()
--        WebRequest.get("https://raw.githubusercontent.com/cgulia/tts-dynamic-links/refs/heads/main/version.json", function(request)
--        if request.is_error then
--            log(request.error)
--        else
--            remoteVersion = tonumber(request.text)
--            if localVersion ~= remoteVersion then
--                prettyPrint("Script version out of date (v[2fff91]" .. remoteVersion .. "[-] available).")
--                prettyPrint("Downloading latest...")
--            end
--        end
--    end)
--end

function onChat(message, player)
    arguments = {}
    for i in string.gmatch(message, "%S+") do
        table.insert(arguments, i)
    end
    
    if arguments[1] == "!r" or "!replace" then
        if arguments[2] ~= nil then 
            fetchAssets(arguments[2])
            prettyPrint("Downloading assets table from [d9d9d9]" .. "[-]")
        end
    end
end

function fetchAssets(link)
    WebRequest.get(link, function(request)
        if request.is_error then
            log(request.error)
        else
            lmAssets = JSON.decode(request.text)
            prettyPrint("Found [2fff91]" .. #lmAssets .. "[-] asset references.")
            parseObjects()
        end
    end)
end

function parseObjects()
    objectIndex = 0
    local allObjects = getAllObjects()
    for o, object in ipairs(allObjects) do
        if object.hasTag("linkmanager") then
            table.insert(objectCache, tostring(object.getJSON()))
            object.destruct()
        end
    end
    Wait.time(function() updateAssetsLoop() end, 0.5, 1)
end

function updateAssetsLoop()
    Wait.time(function() updateAssets() end, 0.1, #objectCache)
end

function updateAssets()
    objectIndex = objectIndex + 1
    local subJson = objectCache[objectIndex]
    for a, asset in ipairs(lmAssets) do
        subJson = string.gsub(subJson, asset.target, asset.link)
        prettyPrint("Replaced [d9d9d9]" .. asset.target .. "[-] with [d9d9d9]" .. asset.link .. "[-]")
    end
    local spawnedObject = spawnObjectJSON({json=subJson})
    if objectIndex == #objectCache then
        prettyPrint("Finished updating ([2fff91]" .. objectIndex .. "/" .. #objectCache .. "[-]) assets.")
        prettyPrint("[b]DELETE[/b] the [33beff][LINK MANAGER][-] utility and [b]SAVE[/b] your mod now.")
    end

end

function prettyPrint(string)
    local prefix = "[33beff][LINK MANAGER][-]: "
    printToAll(prefix .. string)
end