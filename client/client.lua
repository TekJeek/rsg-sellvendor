local QRCore = exports['qr-core']:GetCoreObject()

Citizen.CreateThread(function()
    for k,v in pairs(Config.VendorShops) do
        exports['qr-core']:createPrompt(v.uid, v.pos, QRCore.Shared.Keybinds['J'], v.header, {
            type = 'client',
            event = 'rsg-sellvendor:client:openmenu',
            args = {v.uid}
        })  
    end
end)

RegisterNetEvent('rsg-sellvendor:client:openmenu') 
AddEventHandler('rsg-sellvendor:client:openmenu', function(menuid)
    local shoptable = {
        {
            header = "| "..getMenuTitle(menuid).." |",
            isMenuHeader = true,
        },
    }
    local closemenu = {
        header = "Close menu",
        txt = '', 
        params = {
            event = 'qbr-menu:closeMenu',
        }
    }
    for k,v in pairs(Config.VendorShops) do
        if v.uid == menuid then
            for g,f in pairs(v.shopdata) do
                local lineintable = {
					header = "<img src=nui://qr-inventory/html/images/"..f.image.." width=20px>"..f.title..' (price $'..f.price..')',
                    params = {
                        event = 'rsg-sellvendor:client:sellcount',
                        args = {menuid, f}
                    }
                }
                table.insert(shoptable, lineintable)
            end 
        end
    end
    table.insert(shoptable,closemenu)
	exports['qr-menu']:openMenu(shoptable)
end)

RegisterNetEvent('rsg-sellvendor:client:sellcount') 
AddEventHandler('rsg-sellvendor:client:sellcount', function(arguments)
    local menuid = arguments[1]
    local data = arguments[2]
    local inputdata = exports['qr-input']:ShowInput({
        header = "Enter the number of 1pc / "..data.price.." $",
		submitText = "sell",
		inputs = {
            {
                text = data.description,
                input = "amount",
                type = "number",
                isRequired = true
            },
		}
    })
    if inputdata ~= nil then
        for k,v in pairs(inputdata) do
			TriggerServerEvent('rsg-sellvendor:server:sellitem', v,data)
        end
    end
end)


function getMenuTitle(menuid)
    for k,v in pairs(Config.VendorShops)  do
        if menuid == v.uid then
            return v.header
        end
    end
end
