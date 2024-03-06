fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Tim - PK'
description 'MobilePay script via command, lavet med lb-phone notifys.'

shared_scripts {
    '@ox_lib/init.lua'
}

server_scripts {
    'server/main.lua'
}

dependencies {
    'ox_lib',
    'lb-phone'
}