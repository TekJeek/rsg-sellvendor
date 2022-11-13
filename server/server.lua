local QRCore = exports['qr-core']:GetCoreObject()

RegisterServerEvent('rsg-sellvendor:server:sellitem')
AddEventHandler('rsg-sellvendor:server:sellitem', function(amount, data)
	local src = source
    local Player = QRCore.Functions.GetPlayer(src)
	local amount = tonumber(amount)
	local checkitem = Player.Functions.GetItemByName(data.item)
	if amount >= 0 then
		if checkitem ~= nil then
			local amountitem = Player.Functions.GetItemByName(data.item).amount
			if amountitem >= amount then
				totalcash = (amount * data.price) 
				Player.Functions.RemoveItem(data.item, amount)
				TriggerClientEvent('inventory:client:ItemBox', src, QRCore.Shared.Items[data.item], "remove")
				Player.Functions.AddMoney('cash', totalcash)
				TriggerClientEvent('QRCore:Notify', src, 'You sold ' ..amount.. ' for  $'..totalcash, 'success')
			else
				TriggerClientEvent('QRCore:Notify', src, 'You don\'t have that much on you.', 'error')
			end
		else
			TriggerClientEvent('QRCore:Notify', src, 'You don\'t have an item on you', 'error')
		end
	else
		TriggerClientEvent('QRCore:Notify', src, 'must not be a negative value.', 'error')
	end
end)

