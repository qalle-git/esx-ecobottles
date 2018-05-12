local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}


--- action functions
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local lastTime                = 0
local hasPant                 = false


--- esx
local GUI = {}
ESX                           = nil
GUI.Time                      = 0
local PlayerData              = {}

Citizen.CreateThread(function ()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
 	PlayerData = ESX.GetPlayerData()
  end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

--soptunna
AddEventHandler('esx_pantsystem:EnteredEntityZone', function(entity)
  local pP = GetPlayerPed(-1)

    CurrentAction = 'open_trash'
    CurrentActionMsg = 'Tryck E för att leta flaskor'
    CurrentActionData = {entity = entity}

end)

AddEventHandler('esx_pantsystem:ExitedEntityZone', function(entity)

    if CurrentAction == 'open_trash' then
      CurrentAction = nil
    end

end)

Citizen.CreateThread(function()
  while true do

    Citizen.Wait(0)

    local pP = GetPlayerPed(-1)
    local coords = GetEntityCoords(pP)
    local luck = math.random(1, 10)

      local entity, distance = ESX.Game.GetClosestObject({
        'prop_bin_01a',
        'prop_bin_03a',
        'prop_bin_05a',
      })

        if distance ~= -1 and distance <= 1.5 then
          if entity then
            TriggerEvent('esx_pantsystem:EnteredEntityZone', entity)
            LastEntity = entity
          end

        else

          if entity ~= nil then
            TriggerEvent('esx_pantsystem:ExitedEntityZone', entity)
        end
    end
  end
end)

function OpenTrashCan()
  local pP = GetPlayerPed(-1)

  Citizen.CreateThread(function()

    local pP = GetPlayerPed(-1)
    TaskPlayAnim(pP, "amb@prop_human_bum_bin@enter", "enter", 3.5, -8, -1, 2, 0, 0, 0, 0, 0)
    TaskStartScenarioInPlace(pP, "PROP_HUMAN_BUM_BIN", 0, true)
    Citizen.CreateThread(function()
      Citizen.Wait(10000)
      TriggerServerEvent('esx_pantsystem:givePant')
      ClearPedTasksImmediately(pP)
      end)
    end)
end

----markers
AddEventHandler('esx_duty:hasEnteredMarker', function (zone)
  if zone == 'Pant' then
    CurrentAction     = 'pant_flaskor'
    CurrentActionMsg  = _U('press_e')
    CurrentActionData = {}
  end
end)

AddEventHandler('esx_duty:hasExitedMarker', function (zone)
  CurrentAction = nil
end)


--keycontrols
-- Key Controls
Citizen.CreateThread(function()
  while true do

    Citizen.Wait(0)

  if CurrentAction ~= nil then

    SetTextComponentFormat('STRING')
    AddTextComponentString(CurrentActionMsg)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)

    if IsControlPressed(0,  Keys['E']) then
        if CurrentAction == 'pant_flaskor' then
          TriggerServerEvent('esx_pantsystem:Pant', 'bottle')
        end

        if CurrentAction == 'open_trash' then
          if GetGameTimer() - lastTime >= 15000 then 
            OpenTrashCan()
            lastTime = GetGameTimer()
          end
        end

          CurrentAction = nil               
      end
    end
  end
end)

-- Display markers
Citizen.CreateThread(function ()
  while true do
    Wait(0)

    local coords = GetEntityCoords(GetPlayerPed(-1))

    for k,v in pairs(Config.Zones) do
      if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
        DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
      end
    end
  end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function ()
  while true do
    Wait(0)

    local coords      = GetEntityCoords(GetPlayerPed(-1))
    local isInMarker  = false
    local currentZone = nil

    for k,v in pairs(Config.Zones) do
      if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
        isInMarker  = true
        currentZone = k
      end
    end

    if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
      HasAlreadyEnteredMarker = true
      LastZone                = currentZone
      TriggerEvent('esx_duty:hasEnteredMarker', currentZone)
    end

    if not isInMarker and HasAlreadyEnteredMarker then
      HasAlreadyEnteredMarker = false
      TriggerEvent('esx_duty:hasExitedMarker', LastZone)
    end
  end
end)


---alla grejer
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer

  TriggerEvent('esx_pantsystem:hasNotPant')

  for i=1, #PlayerData.inventory, 1 do
    if PlayerData.inventory[i].name == 'bottle' then
      if PlayerData.inventory[i].count > 0 then
        TriggerEvent('esx_pantsystem:hasPant')
      end
    end
  end
end)


RegisterNetEvent('esx_pantsystem:hasNotPant')
AddEventHandler('esx_pantsystem:hasNotPant', function()
  hasPant = false
end)

RegisterNetEvent('esx_pantsystem:hasPant')
AddEventHandler('esx_pantsystem:hasPant', function()
  hasPant = true
end)

--notification
function sendNotification(message, messageType, messageTimeout)
	TriggerEvent("pNotify:SendNotification", {
		text = message,
		type = messageType,
		queue = "duty",
		timeout = messageTimeout,
		layout = "bottomCenter"
	})
end