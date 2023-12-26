local RSGCore = exports['rsg-core']:GetCoreObject()

---------------------------------------------
-- prompts and blips
---------------------------------------------
Citizen.CreateThread(function()
    for sellvendor, v in pairs(Config.VendorShops) do
        exports['rsg-core']:createPrompt(v.prompt, v.coords, RSGCore.Shared.Keybinds['J'], v.header, {
            type = 'client',
            event = 'rsg-sellvendor:client:openmenu',
            args = { v.prompt },
        })
        if v.showblip == true then
            local SellVendorBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(SellVendorBlip, GetHashKey(v.blip.blipSprite), true)
            SetBlipScale(SellVendorBlip, v.blip.blipScale)
            Citizen.InvokeNative(0x9CB1A1623062F402, SellVendorBlip, v.blip.blipName)
        end
    end
end)

---------------------------------------------
-- sell vendor menu
---------------------------------------------
RegisterNetEvent('rsg-sellvendor:client:openmenu')
AddEventHandler('rsg-sellvendor:client:openmenu', function(menuid)
    local options = {}
    for k, v in pairs(Config.VendorShops) do
        if v.prompt == menuid then
            for g,f in pairs(v.shopdata) do
               local itemimg = "nui://"..Config.img..RSGCore.Shared.Items[tostring(f.item)].image  
                options[#options + 1] = {
                    title = f.title..' ( vendor buy price $'..f.price..' )',
                    icon = itemimg,
                    event = 'rsg-sellvendor:client:sellcount',
                    args = { item = f.item , price = f.price, label = f.title },
                    arrow = true,
                }
            end
        end
        lib.registerContext({
            id = 'sell_vendor',
            title = getMenuTitle(menuid),
            position = 'top-right',
            options = options
        })
        lib.showContext('sell_vendor')        
    end
end)

---------------------------------------------
-- sell amount
---------------------------------------------
RegisterNetEvent('rsg-sellvendor:client:sellcount', function(data)
    print(data.item, data.price, data.label)
    local input = lib.inputDialog('Sell '..data.label, {
        { 
            label = 'Amount',
            type = 'input',
            required = true,
            icon = 'fa-solid fa-hashtag'
        },
    })
    
    if not input then
        return
    end
    
    local hasItem = RSGCore.Functions.HasItem(data.item, input[1])
    
    if hasItem then
        TriggerServerEvent('rsg-sellvendor:server:sellitem', data.item, input[1], data.price)
    else
        lib.notify({ title = 'Issue Found', description = 'you don\'t have enough of that item to sell!', type = 'error', duration = 7000 })
    end
    
end)

function getMenuTitle(menuid)
    for k,v in pairs(Config.VendorShops)  do
        if menuid == v.prompt then
            return v.header
        end
    end
end
