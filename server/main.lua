ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx-ecobottles:sellBottles')
AddEventHandler('esx-ecobottles:sellBottles', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    local currentBottles = xPlayer.getInventoryItem('bottle').count
    local randomMoney = math.random(5, 10)

    if currentBottles > 0 then
        xPlayer.removeInventoryItem('bottle', currentBottles)
        xPlayer.addMoney(randomMoney * currentBottles)
    TriggerClientEvent("pNotify:SetQueueMax", source, "center", 5)
     TriggerClientEvent("pNotify:SendNotification", source, {
        text = "You gave the store " .. currentBottles .. " bottles and recieved $" .. randomMoney * currentBottles .. "!",
        type = "success",
        progressBar = true,
        queue = "center",
        timeout = 3000,
        layout = "Center"
    }) 
    else
    TriggerClientEvent("pNotify:SetQueueMax", source, "center", 5)
    TriggerClientEvent("pNotify:SendNotification", source, {
        text = "You don\'t have enough bottles!",
        type = "error",
        progressBar = true,
        queue = "center",
        timeout = 3000,
        layout = "Center"
    }) 
    end
end)


RegisterServerEvent('esx-ecobottles:retrieveBottle')
AddEventHandler('esx-ecobottles:retrieveBottle', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    local luck = math.random(0, 300)
    local randomBottle = math.random(1, 3)
    local money = math.random(1, 20)

    if luck >= 0 and luck <= 29 then
        xPlayer.addMoney(money)
    TriggerClientEvent("pNotify:SetQueueMax", source, "center", 5)
    TriggerClientEvent("pNotify:SendNotification", source, {
        text = "Našel jsi $".. money .."",
        type = "success",
        progressBar = true,
        queue = "center",
        timeout = 3000,
        layout = "Center"
    }) 
    end
    if luck >= 30 and luck <= 60 then
        xPlayer.addInventoryItem('bottle', randomBottle)
    TriggerClientEvent("pNotify:SetQueueMax", source, "center", 5)
    TriggerClientEvent("pNotify:SendNotification", source, {
        text = "Našel jsi ".. randomBottle .." vratných lahví",
        type = "success",
        progressBar = true,
        queue = "center",
        timeout = 3000,
        layout = "Center"
    }) 
    end
    if luck >= 55 and luck <= 65 then
        xPlayer.addInventoryItem('clip', 1)
    TriggerClientEvent("pNotify:SetQueueMax", source, "center", 5)
    TriggerClientEvent("pNotify:SendNotification", source, {
        text = "Našel jsi náboje do zbraně",
        type = "success",
        progressBar = true,
        queue = "center",
        timeout = 3000,
        layout = "Center"
    }) 
    end
    if luck >= 66 and luck <= 80 then
        xPlayer.addInventoryItem('bandage', 1)
    TriggerClientEvent("pNotify:SetQueueMax", source, "center", 5)
    TriggerClientEvent("pNotify:SendNotification", source, {
        text = "Našel jsi obvaz",
        type = "success",
        progressBar = true,
        queue = "center",
        timeout = 3000,
        layout = "Center"
    })    
    end
    if luck >= 79 and luck <= 99 then
        xPlayer.addInventoryItem('vodka', 1)
    TriggerClientEvent("pNotify:SetQueueMax", source, "center", 5)
    TriggerClientEvent("pNotify:SendNotification", source, {
        text = "Našel jsi nedopitou flašku vodky",
        type = "success",
        progressBar = true,
        queue = "center",
        timeout = 3000,
        layout = "Center"
    })    
    end     
    if luck >= 98 and luck <= 110 then
        xPlayer.addInventoryItem('jumelles', 1)
    TriggerClientEvent("pNotify:SetQueueMax", source, "center", 5)
    TriggerClientEvent("pNotify:SendNotification", source, {
        text = "Našel jsi dalekohled",
        type = "success",
        progressBar = true,
        queue = "center",
        timeout = 3000,
        layout = "Center"
    })   
    end   
    if luck >= 109 and luck <= 130 then
        xPlayer.addInventoryItem('cigarett', 1)
    TriggerClientEvent("pNotify:SetQueueMax", source, "center", 5)
    TriggerClientEvent("pNotify:SendNotification", source, {
        text = "Našel jsi vajgl",
        type = "success",
        progressBar = true,
        queue = "center",
        timeout = 3000,
        layout = "Center"
    })  
    end      
    if luck >= 111 and luck <= 120 then
        xPlayer.addInventoryItem('brolly', 1)
    TriggerClientEvent("pNotify:SetQueueMax", source, "center", 5)
    TriggerClientEvent("pNotify:SendNotification", source, {
        text = "Našel jsi deštník",
        type = "success",
        progressBar = true,
        queue = "center",
        timeout = 3000,
        layout = "Center"
    })   
    end  
    if luck >= 121 and luck <= 130 then
        xPlayer.addInventoryItem('kufr', 1)
    TriggerClientEvent("pNotify:SetQueueMax", source, "center", 5)
    TriggerClientEvent("pNotify:SendNotification", source, {
        text = "Našel jsi kufřík",
        type = "success",
        progressBar = true,
        queue = "center",
        timeout = 3000,
        layout = "Center"
    })    
    end  
    if luck >= 131 and luck <= 150 then
        xPlayer.addInventoryItem('dyrkset', 1)
    TriggerClientEvent("pNotify:SetQueueMax", source, "center", 5)
    TriggerClientEvent("pNotify:SendNotification", source, {
        text = "Našel jsi páčidlo",
        type = "success",
        progressBar = true,
        queue = "center",
        timeout = 3000,
        layout = "Center"
    }) 
    end           
    if luck >= 151 and luck <= 165 then
        xPlayer.addInventoryItem('beer', 1)
    TriggerClientEvent("pNotify:SetQueueMax", source, "center", 5)
    TriggerClientEvent("pNotify:SendNotification", source, {
        text = "Našel jsi láhev s pivem",
        type = "success",
        progressBar = true,
        queue = "center",
        timeout = 3000,
        layout = "Center"
    }) 
    end       
    if luck >= 166 and luck <= 180 then
        xPlayer.addInventoryItem('lighter', 1)
    TriggerClientEvent("pNotify:SetQueueMax", source, "center", 5)
    TriggerClientEvent("pNotify:SendNotification", source, {
        text = "Našel jsi zapalovač",
        type = "success",
        progressBar = true,
        queue = "center",
        timeout = 3000,
        layout = "Center"
    })  
    end         
    if luck >= 181 and luck <= 191 then
        xPlayer.addInventoryItem('rose', 1)
    TriggerClientEvent("pNotify:SetQueueMax", source, "center", 5)
    TriggerClientEvent("pNotify:SendNotification", source, {
        text = "Našel jsi růži",
        type = "success",
        progressBar = true,
        queue = "center",
        timeout = 3000,
        layout = "Center"
    }) 
    end           
    if luck >= 192 and luck <= 300 then
    TriggerClientEvent("pNotify:SetQueueMax", source, "center", 5)
    TriggerClientEvent("pNotify:SendNotification", source, {
        text = "No bottle where found",
        type = "error",
        progressBar = true,
        queue = "center",
        timeout = 3000,
        layout = "Center"
    })
    end                              
end)