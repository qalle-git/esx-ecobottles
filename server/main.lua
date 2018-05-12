ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:onAddInventoryItem', function(source, item, count)
  if item.name == 'bottle' then
    TriggerClientEvent('esx_pantsystem:hasPant', source)
  end
end)

--har inte item
AddEventHandler('esx:onRemoveInventoryItem', function(source, item, count)
  if item.name == 'bottle' and item.count < 1 then
    TriggerClientEvent('esx_pantsystem:hasNotPant', source)
  end
end)

RegisterServerEvent('esx_pantsystem:Pant')
AddEventHandler('esx_pantsystem:Pant', function(item)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local pant = xPlayer.getInventoryItem(item).count
    local randomMoney = math.random(1, 4)

    if pant > 0 then
        xPlayer.removeInventoryItem(item, pant)
        xPlayer.addMoney(randomMoney)
        sendNotification(_source, 'Du pantade '..math.floor(pant)..'st flaskor '..' för '..randomMoney..' SEK', 'success', 2500)
    elseif pant < 1 then
        sendNotification(_source, 'Du har ingen pant att panta.', 'error', 2500)
    end
end)


RegisterServerEvent('esx_pantsystem:givePant')
AddEventHandler('esx_pantsystem:givePant', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local luck = math.random(0, 69)
    local randomBottle = math.random(1, 12)

    if luck >= 0 and luck <= 29 then
        sendNotification(_source, 'Inga flaskor hittades', 'error', 2500)
    end
    if luck >= 29 and luck < 69 then
        xPlayer.addInventoryItem('bottle', randomBottle)
        sendNotification(_source, 'Du hittade ' .. randomBottle.. 'st flaskor', 'success', 2500)
    end
end)


--notification
function sendNotification(xSource, message, messageType, messageTimeout)
    TriggerClientEvent("pNotify:SendNotification", xSource, {
        text = message,
        type = messageType,
        queue = "qalle",
        timeout = messageTimeout,
        layout = "bottomCenter"
    })
end