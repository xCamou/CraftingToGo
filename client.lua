ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('crafting:startCrafting')
AddEventHandler('crafting:startCrafting', function(usableItem)
    local playerPed = PlayerPedId()
    
    for _, recipe in ipairs(Config.Recipes) do
        if recipe.usableItem == usableItem then
            ESX.Streaming.RequestAnimDict(recipe.animation.dict, function()
                TaskPlayAnim(playerPed, recipe.animation.dict, recipe.animation.name, 8.0, -8.0, recipe.animation.time, 1, 0, false, false, false)
                Citizen.Wait(recipe.animation.time)
                ClearPedTasks(playerPed)
                
                TriggerServerEvent('crafting:removeIngredients', recipe)
            end)
            break
        end
    end
end)
