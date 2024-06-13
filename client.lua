local Framework = nil

if Config.Framework == 'ESX' then
    Framework = exports['es_extended']:getSharedObject()
elseif Config.Framework == 'QBCore' then
    Framework = exports['qb-core']:GetCoreObject()
end

RegisterNetEvent('crafting:startCrafting')
AddEventHandler('crafting:startCrafting', function(usableItem)
    local playerPed = PlayerPedId()

    for _, recipe in ipairs(Config.Recipes) do
        if recipe.usableItem == usableItem then
            if Config.Framework == 'ESX' then
                ESX.Streaming.RequestAnimDict(recipe.animation.dict, function()
                    TaskPlayAnim(playerPed, recipe.animation.dict, recipe.animation.name, 8.0, -8.0, recipe.animation.time, 1, 0, false, false, false)
                    Citizen.Wait(recipe.animation.time)
                    ClearPedTasks(playerPed)
                    TriggerServerEvent('crafting:removeIngredients', recipe)
                end)
            elseif Config.Framework == 'QBCore' then
                QBCore.Functions.RequestAnimDict(recipe.animation.dict, function()
                    TaskPlayAnim(playerPed, recipe.animation.dict, recipe.animation.name, 8.0, -8.0, recipe.animation.time, 1, 0, false, false, false)
                    Citizen.Wait(recipe.animation.time)
                    ClearPedTasks(playerPed)
                    TriggerServerEvent('crafting:removeIngredients', recipe)
                end)
            end
            break
        end
    end
end)
