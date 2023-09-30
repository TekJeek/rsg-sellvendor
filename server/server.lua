local RSGCore = exports['rsg-core']:GetCoreObject()

-----------------------------------------------------------------------
-- version checker
-----------------------------------------------------------------------
local function versionCheckPrint(_type, log)
    local color = _type == 'success' and '^2' or '^1'

    print(('^5['..GetCurrentResourceName()..']%s %s^7'):format(color, log))
end

local function CheckVersion()
    PerformHttpRequest('https://raw.githubusercontent.com/Rexshack-RedM/rsg-sellvendor/main/version.txt', function(err, text, headers)
        local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version')

        if not text then 
            versionCheckPrint('error', 'Currently unable to run a version check.')
            return 
        end

        --versionCheckPrint('success', ('Current Version: %s'):format(currentVersion))
        --versionCheckPrint('success', ('Latest Version: %s'):format(text))
        
        if text == currentVersion then
            versionCheckPrint('success', 'You are running the latest version.')
        else
            versionCheckPrint('error', ('You are currently running an outdated version, please update to version %s'):format(text))
        end
    end)
end

-----------------------------------------------------------------------

RegisterServerEvent('rsg-sellvendor:server:sellitem')
AddEventHandler('rsg-sellvendor:server:sellitem', function(amount, data)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local amount = tonumber(amount)
    local checkitem = Player.Functions.GetItemByName(data.item)
    if amount >= 0 then
        if checkitem ~= nil then
            local amountitem = Player.Functions.GetItemByName(data.item).amount
            if amountitem >= amount then
                totalcash = (amount * data.price) 
                Player.Functions.RemoveItem(data.item, amount)
                TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[data.item], "remove")
                Player.Functions.AddMoney('cash', totalcash)
                TriggerClientEvent('RSGCore:Notify', src, 'You sold ' ..amount.. ' for  $'..totalcash, 'success')
            else
                TriggerClientEvent('RSGCore:Notify', src, 'You don\'t have that much on you.', 'error')
            end
        else
            TriggerClientEvent('RSGCore:Notify', src, 'You don\'t have an item on you', 'error')
        end
    else
        TriggerClientEvent('RSGCore:Notify', src, 'must not be a negative value.', 'error')
    end
end)

--------------------------------------------------------------------------------------------------
-- start version check
--------------------------------------------------------------------------------------------------
CheckVersion()
