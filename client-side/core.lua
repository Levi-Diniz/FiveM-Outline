-----------------------------------------------------------------------------------------------------------------------------------------
-- CONFIG
-----------------------------------------------------------------------------------------------------------------------------------------
local outlineConfig = {
    color = { r = 0, g = 255, b = 0, a = 150 }, -- Green
    shader = 1,
    technique = "waterreflection",
    distance = 100.0,
    updateInterval = 500 -- ms for the heavy check (distance/ally)
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- STATE
-----------------------------------------------------------------------------------------------------------------------------------------
local activeOutlines = {} -- To keep track of who currently has the outline

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
---Setup the global outline parameters
local function setupOutline()
    SetEntityDrawOutlineColor(outlineConfig.color.r, outlineConfig.color.g, outlineConfig.color.b, outlineConfig.color.a)
    SetEntityDrawOutlineShader(outlineConfig.shader)
    SetEntityDrawOutlineRenderTechnique(outlineConfig.technique)
end

---Check if a player is an ally
---@param serverId number
---@return boolean
local function isAlly(serverId)
    -- Placeholder for ally logic. 
    -- You can integrate this with your party system, group system, etc.
    -- Example: return Player(serverId).state.party == LocalPlayer.state.party
    return true -- For now, we'll treat everyone as an "ally" for testing
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    setupOutline()

    while true do
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local players = GetActivePlayers()

        for _, player in ipairs(players) do
            local targetPed = GetPlayerPed(player)
            
            if targetPed ~= playerPed and DoesEntityExist(targetPed) then
                local targetCoords = GetEntityCoords(targetPed)
                local distance = #(playerCoords - targetCoords)
                local serverId = GetPlayerServerId(player)

                -- Conditions: Within distance, Alive, and is an Ally
                local shouldShow = distance <= outlineConfig.distance and not IsPedDeadOrDying(targetPed, true) and isAlly(serverId)

                if shouldShow then
                    if not activeOutlines[serverId] then
                        SetEntityDrawOutline(targetPed, true)
                        activeOutlines[serverId] = true
                    end
                else
                    if activeOutlines[serverId] then
                        SetEntityDrawOutline(targetPed, false)
                        activeOutlines[serverId] = nil
                    end
                end
            end
        end

        Citizen.Wait(outlineConfig.updateInterval)
    end
end)

-- Handle resource stop to clean up outlines
AddEventHandler("onResourceStop", function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    
    for serverId, _ in pairs(activeOutlines) do
        local player = GetPlayerFromServerId(serverId)
        if player ~= -1 then
            local ped = GetPlayerPed(player)
            if DoesEntityExist(ped) then
                SetEntityDrawOutline(ped, false)
            end
        end
    end
end)
