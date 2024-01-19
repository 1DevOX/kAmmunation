ESX = exports["es_extended"]:getSharedObject()

Prefix = GetCurrentResourceName()

RegisterServerEvent("weapon")
AddEventHandler("weapon",function(item,prix,nombre)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local getmoney = xPlayer.getMoney()
    if getmoney >= prix then
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Amunation',
            description = k.notification1,
            position = 'top',
            duration = 5000,
            icon = 'fa-solid fa-star',
            type = 'success',
            style = {
                borderRadius = 6,
                backgroundColor = '#141517',
                color = '#FFFFFF',
                ['.description'] = {
                  color = '#909296'
                },
            },
        })
    xPlayer.removeMoney(prix)
    xPlayer.addInventoryItem(item,nombre)
    else
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Amunation',
            description = k.notification2,
            position = 'top',
            icon = 'fa-solid fa-star',
            duration = 5000,
            type = 'error',
            style = {
                borderRadius = 6,
                backgroundColor = '#141517',
                color = '#FFFFFF',
                ['.description'] = {
                  color = '#909296'
                },
            },
        })
    end
end)

RegisterServerEvent("card_member")
AddEventHandler("card_member",function(item, prix)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local getmoney = xPlayer.getMoney()
    if getmoney >= prix then
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Amunation',
            description = k.notification4,
            position = 'top',
            duration = 5000,
            icon = 'fa-solid fa-store',
            type = 'success',
            style = {
                borderRadius = 6,
                backgroundColor = '#141517',
                color = '#FFFFFF',
                ['.description'] = {
                  color = '#909296'
                },
            },
        })
    xPlayer.removeMoney(prix)
    xPlayer.addInventoryItem(item, 1)
    else
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Amunation',
            description = k.notification2,
            position = 'top',
            icon = 'fa-solid fa-store',
            duration = 5000,
            type = 'error',
            style = {
                borderRadius = 6,
                backgroundColor = '#141517',
                color = '#FFFFFF',
                ['.description'] = {
                  color = '#909296'
                },
            },
        })
    end
end)

RegisterServerEvent("stand_add")
AddEventHandler("stand_add",function(item)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem(item, 1)
    xPlayer.addInventoryItem('ammo-9', 12)
end)

RegisterServerEvent("stand_remove")
AddEventHandler("stand_remove",function(item)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem(item, 1)
end)

RegisterServerEvent("stand_money")
AddEventHandler("stand_money",function(item)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local Money = math.random(5,30)
    xPlayer.addInventoryItem(item, Money)
end)

RegisterServerEvent("gestion_givecard")
AddEventHandler("gestion_givecard",function(target, nombre)
    local xPlayer = ESX.GetPlayerFromId(target)
    xPlayer.addInventoryItem('card_member', nombre)
end)

RegisterServerEvent("gestion_supcard")
AddEventHandler("gestion_supcard",function(target, nombre)
    local xPlayer = ESX.GetPlayerFromId(target)
    xPlayer.removeInventoryItem('card_member', nombre)
end)

RegisterServerEvent("spawn_bag")
AddEventHandler("spawn_bag",function(bag, coords)
    local source = source
    local model = bag -- Model can be either a string or a hash
    local coords = coords -- Coords Can either be vector or a table (such as {x = 0, y = 0, z = 0})
    local Heading = 0 -- Sets the Rotation/Heading the ped spawns at, can be any number
    ESX.OneSync.SpawnObject(model,coords, Heading, function(Object)
      Wait(100) -- While not needed, it is best to wait a few milliseconds to ensure the Object is available
      local Exists = DoesEntityExist(Object) -- returns true/false depending on if the Object exists.
      print(Exists and 'Successfully Spawned Object!' or 'Failed to Spawn Failed!')
    end)
end)

RegisterServerEvent('buyppa')
AddEventHandler('buyppa', function(PrixPPA)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local identifier = xPlayer.identifier

    MySQL.Async.fetchAll('SELECT COUNT(*) as count FROM user_licenses WHERE type = @type AND owner = @owner', {
        ['@type']  = 'weapon',
        ['@owner'] = identifier
    }, function(result)
        if tonumber(result[1].count) > 0 then
            TriggerClientEvent('esx:showNotification', _source, 'Vous avez déjà le PPA')
        else
            if xPlayer.getMoney() >= PrixPPA then
                xPlayer.removeMoney(PrixPPA)
                MySQL.Async.execute('INSERT INTO user_licenses (type, owner) VALUES (@type, @owner)', {
                    ['@type']  = 'weapon',
                    ['@owner'] = identifier
                }, function(rowsChanged)
                    TriggerClientEvent('esx:showAdvancedNotification', _source, '~r~Ammunation', '~b~PPA', 'Vous avez obtenu le PPA !', 'CHAR_AMMUNATION', 1)
                end)
            else
                TriggerClientEvent('esx:showAdvancedNotification', _source, '~r~Ammunation', '~b~PPA', 'Vous n\'avez pas assez d\'argent pour acheté le PPA', 'CHAR_AMMUNATION', 1)
            end
        end
    end)
end)

RegisterServerEvent('getppa')
AddEventHandler('getppa', function(PrixPPA)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local identifier = xPlayer.identifier

    MySQL.Async.fetchAll('SELECT COUNT(*) as count FROM user_licenses WHERE type = @type AND owner = @owner', {
        ['@type']  = 'weapon',
        ['@owner'] = identifier
    }, function(result)
        if tonumber(result[1].count) > 0 then
            TriggerClientEvent('esx:showNotification', _source, 'Vous avez déjà le PPA')
        else
            if xPlayer.getMoney() >= PrixPPA then
                TriggerClientEvent('Tire', _source)
                xPlayer.removeMoney(PrixPPA)
            else
                TriggerClientEvent('esx:showAdvancedNotification', _source, '~r~Ammunation', '~b~PPA', 'Vous n\'avez pas assez d\'argent pour acheté le PPA', 'CHAR_AMMUNATION', 1)
            end
        end
    end)
end)

RegisterServerEvent('standppayes')
AddEventHandler('standppayes', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local identifier = xPlayer.identifier

    MySQL.Async.fetchAll('SELECT COUNT(*) as count FROM user_licenses WHERE type = @type AND owner = @owner', {
        ['@type']  = 'weapon',
        ['@owner'] = identifier
    }, function(result)
        if tonumber(result[1].count) > 0 then
            TriggerClientEvent('esx:showNotification', _source, 'Vous avez déjà le PPA')
        else
            MySQL.Async.execute('INSERT INTO user_licenses (type, owner) VALUES (@type, @owner)', {
                ['@type']  = 'weapon',
                ['@owner'] = identifier
            }, function(rowsChanged)
                TriggerClientEvent('esx:showAdvancedNotification', _source, '~r~Ammunation', '~b~PPA', 'Vous avez obtenu le PPA !', 'CHAR_AMMUNATION', 1)
            end)
        end
    end)
end)

RegisterServerEvent('giveppa')
AddEventHandler('giveppa', function(target)
    local xPlayer = ESX.GetPlayerFromId(target)
	local identifier = xPlayer.identifier

    MySQL.Async.fetchAll('SELECT COUNT(*) as count FROM user_licenses WHERE type = @type AND owner = @owner', {
        ['@type']  = 'weapon',
        ['@owner'] = identifier
    }, function(result)
        if tonumber(result[1].count) > 0 then
            TriggerClientEvent('esx:showNotification', target, 'Vous avez déjà le PPA')
        else
                MySQL.Async.execute('INSERT INTO user_licenses (type, owner) VALUES (@type, @owner)', {
                    ['@type']  = 'weapon',
                    ['@owner'] = identifier
                }, function(rowsChanged)
                    TriggerClientEvent('esx:showAdvancedNotification', target, '~r~Ammunation', '~b~PPA', 'Vous avez obtenu le PPA !', 'CHAR_AMMUNATION', 1)
                end)
        end
    end)
end)