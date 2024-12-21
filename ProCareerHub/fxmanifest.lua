fx_version 'cerulean'
game 'gta5'

description 'Police Application System'
author 'Mr.Olson14'
version '1.0.0'
lua54 'yes'

contributors {
    '⸸♱♥ 𝓜𝓻.𝓢𝓜𝓤𝓡𝓕 ♥♱⸸',  -- Contributor
}

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua',
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua'
}