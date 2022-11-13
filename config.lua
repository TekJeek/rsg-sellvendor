Config = {}

Config.VendorShops = {
    -- valentine
    {
        uid = "val-sellshop",  -- must be unique
        header = "Valentine Vendor", -- menu header
        pos = vector3(-355.7784, 775.41345, 116.23655), -- location of sell shop
        ped = { -- npc settings
            enable = true,
            model = "A_M_M_BiVWorker_01",
            pos = vector3(-355.7784, 775.41345, 116.23655),
            head = 0,
        },
        blip = { -- blip settings
            enable = true,
            blipSprite = 'blip_shop_market_stall',
            blipScale = 0.2,
            bliptext = "Valentine Vendor",
        },
        shopdata = { -- shop data
            {
                title = "Bread",
                description = "sell bread",
                price = 0.03,
                item = "bread",
            image = "bread.png"
            },
            {
                title = "Water",
                description = "sell water",
                price = 0.03,
                item = "water",
                image = "water.png"
            },
        },
    },
}
