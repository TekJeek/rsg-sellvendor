fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game 'rdr3'

description 'rsg-sellvendor'
version '1.0.1'

client_script {
    '@ox_lib/init.lua',
    'client/client.lua',
    'config.lua'
}

server_script {
    'server/server.lua',
}

dependencies {
    'rsg-core',
    'ox_lib',
}

lua54 'yes'