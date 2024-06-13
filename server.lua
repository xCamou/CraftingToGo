local Framework = nil

if Config.Framework == 'ESX' then
    Framework = exports['es_extended']:getSharedObject()
elseif Config.Framework == 'QBCore' then
    Framework = exports['qb-core']:GetCoreObject()
end

for _, recipe in ipairs(Config.Recipes) do
    if Config.Framework == 'ESX' then
        ESX.RegisterUsableItem(recipe.usableItem, function(source)
            TriggerClientEvent('crafting:startCrafting', source, recipe.usableItem)
        end)
    elseif Config.Framework == 'QBCore' then
        QBCore.Functions.CreateUseableItem(recipe.usableItem, function(source)
            TriggerClientEvent('crafting:startCrafting', source, recipe.usableItem)
        end)
    end
end

RegisterServerEvent('crafting:removeIngredients')
AddEventHandler('crafting:removeIngredients', function(recipe)
    local src = source
    if Config.Framework == 'ESX' then
        local xPlayer = ESX.GetPlayerFromId(src)
        local hasAllIngredients = true
        for _, ingredient in ipairs(recipe.ingredients) do
            local itemCount = xPlayer.getInventoryItem(ingredient.name).count
            if itemCount < ingredient.count then
                hasAllIngredients = false
                break
            end
        end

        if hasAllIngredients then
            for _, ingredient in ipairs(recipe.ingredients) do
                xPlayer.removeInventoryItem(ingredient.name, ingredient.count)
            end
            xPlayer.addInventoryItem(recipe.result.name, recipe.result.count)
                --add your notification
            TriggerClientEvent("SService:Client:MakeInfoNotify", src, 'success', '[Crafting]', 'Du hast ' .. recipe.result.count .. 'x ' .. ESX.GetItemLabel(recipe.result.name) .. ' hergestellt.', 5000)
        else
                --add your notification
            TriggerClientEvent("SService:Client:MakeInfoNotify", src, 'error', '[Crafting]', 'Du hast nicht alle notwendigen Zutaten.', 5000)
        end
    elseif Config.Framework == 'QBCore' then
        local Player = QBCore.Functions.GetPlayer(src)
        local hasAllIngredients = true
        for _, ingredient in ipairs(recipe.ingredients) do
            local item = Player.Functions.GetItemByName(ingredient.name)
            if not item or item.amount < ingredient.count then
                hasAllIngredients = false
                break
            end
        end

        if hasAllIngredients then
            for _, ingredient in ipairs(recipe.ingredients) do
                Player.Functions.RemoveItem(ingredient.name, ingredient.count)
            end
            Player.Functions.AddItem(recipe.result.name, recipe.result.count)
            TriggerClientEvent("QBCore:Notify", src, 'Du hast ' .. recipe.result.count .. 'x ' .. QBCore.Shared.Items[recipe.result.name].label .. ' hergestellt.', 'success')
        else
            TriggerClientEvent("QBCore:Notify", src, 'Du hast nicht alle notwendigen Zutaten.', 'error')
        end
    end
end)

