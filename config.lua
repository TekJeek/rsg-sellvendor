Config = {}

Config.VendorShops = {
    -- valentine
    {
        prompt = "val-sellshop",  -- must be unique
        header = "Valentine Vendor", -- menu header
        coords = vector3(-355.7784, 775.41345, 116.23655 -0.8), -- location of sell shop
        blip = { -- blip settings
            blipSprite = 'blip_shop_market_stall',
            blipScale = 0.2,
            blipName = "Valentine Vendor",
        },
		showblip = true,
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
    -- guarma trade point
    {
        prompt = "guarma-sellshop",  -- must be unique
        header = "Guarma Vendor", -- menu header
        coords = vector3(1284.16, -6871.74, 43.4), -- location of sell shop
        blip = { -- blip settings
            blipSprite = 'blip_shop_market_stall',
            blipScale = 0.2,
            blipName = "Guarma Vendor",
        },
        showblip = true,
        shopdata = { -- shop data
            {
                title = "Box of Cigars",
                description = "sell your cigar boxes",
                price = 20,
                item = "cigarbox",
                image = "cigarbox.png"
            },
        },
    },
}
