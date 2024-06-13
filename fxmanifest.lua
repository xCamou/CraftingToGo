fx_version 'cerulean'
game 'gta5'

author 'Camou'
description 'Crafting To Go'
version '1.1'

shared_script 'config.lua'

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

dependencies {
    'es_extended', -- use ESX
    --'qb-core' -- use QBCore
}
