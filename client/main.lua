ESX                           = nil

local lastBin = 0

Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(5)
    end

    LoadMarkers()
end)

local Coordinates = {
    { x = 29.337753295898, y = -1770.3348388672, z = 29.607357025146 - 0.945 },
    { x = 388.30194091797, y = -874.88238525391, z = 29.295169830322 - 0.945 },
    { x = 26.877752304077, y = -1343.0764160156, z = 29.497024536133 - 0.945 },
}

function LoadMarkers()
    Citizen.Wait(0)

    Citizen.CreateThread(function()

        for index, value in pairs(Coordinates) do
            local blip = AddBlipForCoord(value.x, value.y, value.z)
    
            SetBlipSprite (blip, 409)
            SetBlipDisplay(blip, 4)
            SetBlipScale  (blip, 0.8)
            SetBlipColour (blip, 48)
            SetBlipAsShortRange(blip, true)
    
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Sell Bottles')
            EndTextCommandSetBlipName(blip)
        end

        while true do
            Citizen.Wait(5)

            local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))

            for id, val in ipairs(Coordinates) do


                local distance = GetDistanceBetweenCoords(x, y, z, val.x, val.y, val.z, true)

                if distance <= 5.0 then
                    DrawMarker(27, val.x, val.y, val.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 255, 255, 255, 100, false, true, 2, false, false, false, false)
                    if distance <= 1.5 then
                        ESX.Game.Utils.DrawText3D({x = val.x, y = val.y, z = val.z + 1}, '[E] Sell Bottles', 0.4)
                        if IsControlJustReleased(0, 38) then
                            TriggerServerEvent('esx-ecobottles:sellBottles')
                        end
                    end
                end

            end
        end
    
    end)
end

Citizen.CreateThread(function()
    while true do

        Citizen.Wait(5)

        local entity, distance = ESX.Game.GetClosestObject({
            'prop_bin_01a',
            'prop_bin_03a',
            'prop_bin_05a',
        })

        if distance ~= -1 and distance <= 1.5 then
            if entity ~= nil then
                local binCoords = GetEntityCoords(entity)
                ESX.Game.Utils.DrawText3D({ x = binCoords.x, y = binCoords.y, z = binCoords.z + 1 }, '[E] Search Trashbin', 0.4)
                if IsControlJustReleased(0, 38) then
                    if lastBin ~= entity then
                        lastBin = entity
                        OpenTrashCan()
                    else
                        ESX.ShowNotification('You\'ve already searched this bin!')
                    end
                end
            else
                Citizen.Wait(500)
            end
        else
            Citizen.Wait(1000)
        end
    end
end)

function OpenTrashCan()
    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
    Citizen.Wait(10000)
    TriggerServerEvent('esx-ecobottles:retrieveBottle')
    ClearPedTasksImmediately(PlayerPedId())
end
