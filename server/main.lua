ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx-ecobottles:sellBottles')
AddEventHandler('esx-ecobottles:sellBottles', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    local currentBottles = xPlayer.getInventoryItem('bottle').count
    local randomMoney = math.random(1, 4)

    if currentBottles > 0 then
        xPlayer.removeInventoryItem('bottle', currentBottles)
        xPlayer.addMoney(randomMoney * currentBottles)
        TriggerClientEvent('esx:showNotification', src, 'You gave the store ' .. currentBottles .. ' bottles and recieved $' .. randomMoney * currentBottles .. '!')
    else
        TriggerClientEvent('esx:showNotification', src, 'You don\'t have enough bottles!')
    end
end)


RegisterServerEvent('esx-ecobottles:retrieveBottle')
AddEventHandler('esx-ecobottles:retrieveBottle', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    local luck = math.random(0, 69)
    local randomBottle = math.random(1, 12)

    if luck >= 0 and luck <= 29 then
        TriggerClientEvent('esx:showNotification', src, 'No bottle where found')
    else
        xPlayer.addInventoryItem('bottle', randomBottle)
        TriggerClientEvent('esx:showNotification', src, 'You found ' .. randomBottle .. ' bottles')
    end
end)
