
Config = {
	useShop = true, -- Do you want a Shop for Bags? 
	Shopcoord = vec3(421.69317626953,-809.66149902344,29.49114418),
	item = { -- item based prop inventory
		[1] = {
			item = 'bag',
			slots = 20,
			weights = 10000,
			model = `ba_prop_battle_bag_01a`, -- prop model
			label = 'Sac a dos', -- label of the item
			price = 10000,
			image = 'bag' -- item name of image in ox /web/build/images/bag.png, make sure to put one there
		},
		[2] = {
			item = 'bag',
			slots = 25,
			weights = 20000,
			model = `xm_prop_x17_bag_med_01a`, -- prop model
			label = 'Sac Medic', -- label of the item
			price = 15000,
			image = 'medicbag' -- item name of image in ox /web/build/images/bag.png, make sure to put one there
		},
		[3] = {
			item = 'bag',
			slots = 35,
			weights = 40000,
			model = `prop_mb_crate_01a`, -- prop model
			label = 'Boite a fusils', -- label of the item
			price = 10000,
			image = 'weaponcrate' -- item name of image in ox /web/build/images/bag.png, make sure to put one there
		},
		[4] = {
			item = 'bag',
			slots = 20,
			weights = 20000,
			model = `prop_ld_suitcase_02`, -- prop model
			label = 'Sac a voyage', -- label of the item
			price = 10000,
			image = 'suitcase' -- item name of image in ox /web/build/images/bag.png, make sure to put one there
		},
	}
}