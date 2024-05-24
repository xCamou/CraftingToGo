ESX = exports['es_extended']:getSharedObject()

for _, recipe in ipairs(Config.Recipes) do
    ESX.RegisterUsableItem(recipe.usableItem, function(source)
        print("Usable item used: " .. recipe.usableItem)
        TriggerClientEvent('crafting:startCrafting', source, recipe.usableItem)
    end)
end

RegisterServerEvent('crafting:removeIngredients')
AddEventHandler('crafting:removeIngredients', function(recipe)
    local xPlayer = ESX.GetPlayerFromId(source)
    print("Removing ingredients for recipe result: " .. recipe.result.name)

    local hasAllIngredients = true
    for _, ingredient in ipairs(recipe.ingredients) do
        local itemCount = xPlayer.getInventoryItem(ingredient.name).count
        print("Checking ingredient: " .. ingredient.name .. ", needed: " .. ingredient.count .. ", player has: " .. itemCount)
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
        TriggerClientEvent('esx:showNotification', source, 'Du hast ' .. recipe.result.count .. 'x ' .. ESX.GetItemLabel(recipe.result.name) .. ' hergestellt.')
    else
        TriggerClientEvent('esx:showNotification', source, 'Du hast nicht alle notwendigen Zutaten.')
    end
end)


