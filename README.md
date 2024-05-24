# CraftingToGo
Simple script to craft anywhere and anytime

A simple script with which you can craft everywhere without using positions.

example:
You have a broken cell phone and a battery with you?
Use the battery to start crafting and get a working cell phone :D

Sorry for my bad English :D

--[[ConfigFile]]
Config.Recipes = {
    {
        result = { name = "weed_joint", count = 1 }, --The finished item
        ingredients = {
            { name = "weed_papers", count = 1 }, --The recipe can use any number of items
            { name = "weed_budclean", count = 5 }
        },
        usableItem = "weed_papers", --The item you have to use in your inventory to start the crafting process
        animation = {
            dict = "mini@repair",
            name = "fixing_a_ped",
            time = 5000
        }
    },


The script can be changed by anyone but cannot be sold.
Feel free to share your changes with us.
