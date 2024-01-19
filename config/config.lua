k = {}

--- ### SYSTEM ### ---

k.systemAmunation = 'target' -- 'automatic' or 'target'
k.systemStand = 'target' -- 'automatic' or 'target'
k.ped = 'boy' -- 'boy' or 'girl' 
k.amunation = { x = 22.48, y = -1105.51, z = 28.78, h = 167.24 } -- custom x, y, z, h
k.ppa = 100 -- price
k.card = 70 -- price
k.other = 'true' -- if 'true' then categorie active else if 'false' then categorie did'nt active !
k.gestion = {
    "TON NOM", -- hardcap (tu peux en rajouter)
}
k.gestion_vip = {
    "TON NOM", -- hardcap (tu peux en rajouter)
}

--- ### ARMES ### ---

k.weapon = {
    { label = 'Pistolet', model = 'weapon_pistol', price = '100', disabled = false },
    { label = 'Double Action', model = 'weapon_doubleaction', price = '50', disabled = false },
    { label = 'Revolver', model = 'weapon_revolver', price = '50', disabled = false },
    { label = 'Flare Gun', model = 'weapon_flaregun', price = '50', disabled = false },
    { label = 'S.M.G', model = 'weapon_smg', price = '50', disabled = false },
    { label = 'Mini S.M.G', model = 'weapon_minismg', price = '50', disabled = false },
    { label = 'Pump Shotgun', model = 'weapon_pumpshotgun', price = '50', disabled = false },
    { label = 'Assault Shotgun', model = 'weapon_assaultshotgun', price = '50', disabled = false },
    { label = 'Musket', model = 'weapon_musket', price = '50', disabled = false },
    { label = 'Double Shotgun', model = 'weapon_dbshotgun', price = '50', disabled = false },
    { label = 'Assault Rifle', model = 'weapon_assaultrifle', price = '50', disabled = false },
    { label = 'Carabine Rifle', model = 'weapon_carbinerifle', price = '50', disabled = false },
    { label = 'Special Carabine', model = 'weapon_specialcarbine', price = '50', disabled = false },
    { label = 'M.G', model = 'weapon_mg', price = '50', disabled = false },
    { label = 'Combat M.G', model = 'weapon_combatmg', price = '50', disabled = false },
    { label = 'Sniper Rifle', model = 'weapon_sniperrifle', price = '50', disabled = false },
    { label = 'HeavySniper Mk2', model = 'weapon_heavysniper_mk2', price = '50', disabled = false },
    { label = 'PrecisionSniper Rifle', model = 'weapon_precisionrifle', price = '50', disabled = false },
    { label = 'R.P.G', model = 'weapon_rpg', price = '50', disabled = true },
    { label = 'Grenade Gun', model = 'weapon_grenadelauncher', price = '50', disabled = true },
    { label = 'MiniGun', model = 'weapon_minigun', price = '50', disabled = true },
    { label = 'FireWork', model = 'weapon_firework', price = '50', disabled = true },
    { label = 'Compact Launcher', model = 'weapon_compactlauncher', price = '50', disabled = true },
    { label = 'E.M.P Launcher', model = 'weapon_emplauncher', price = '50', disabled = true },
}

k.weapon_melee = {
    { label = 'Knife', model = 'weapon_knife', price = '100', disabled = false },
    { label = 'Dagger', model = 'weapon_dagger', price = '50', disabled = false },
    { label = 'Golf Club', model = 'weapon_golfclub', price = '50', disabled = false },
    { label = 'Hammer', model = 'weapon_hammer', price = '50', disabled = false },
    { label = 'Bat', model = 'weapon_bat', price = '50', disabled = false },
    { label = 'Hache', model = 'weapon_hatchet', price = '50', disabled = false },
    { label = 'Machete', model = 'weapon_machete', price = '50', disabled = false },
    { label = 'NightStick', model = 'weapon_nightstick', price = '50', disabled = false },
    { label = 'Wrench', model = 'weapon_wrench', price = '50', disabled = false },
    { label = 'Grenade', model = 'weapon_grenade', price = '50', disabled = false },
    { label = 'Gaz Grenade', model = 'weapon_bzgas', price = '50', disabled = false },
    { label = 'Molotov', model = 'weapon_molotov', price = '50', disabled = false },
    { label = 'StickyBomb', model = 'weapon_stickybomb', price = '50', disabled = false },
    { label = 'Proxy Mine', model = 'weapon_proxmine', price = '50', disabled = false },
    { label = 'Pipe Bomb', model = 'weapon_proxmine', price = '50', disabled = false },
    { label = 'Smoke Bomb', model = 'weapon_smokegrenade', price = '50', disabled = false },
}

k.weapon_other = {
    { label = 'Jerry Can', model = 'weapon_petrolcan', price = '100', disabled = false },
}

k.weapon_vip = {
    { label = 'R.P.G', model = 'weapon_rpg', price = '50' },
    { label = 'Grenade Gun', model = 'weapon_grenadelauncher', price = '50' },
    { label = 'MiniGun', model = 'weapon_minigun', price = '50' },
    { label = 'FireWork', model = 'weapon_firework', price = '50' },
    { label = 'Compact Launcher', model = 'weapon_compactlauncher', price = '50' },
    { label = 'E.M.P Launcher', model = 'weapon_emplauncher', price = '50' },
}

--- ### NE PAS TOUCHER ### ---

k.stand = {
    { x = 8.47, y = -1095.21, z = 29.81 },
    { x = 100, y = 100, z = 100 },
    { x = 100, y = 100, z = 100 },
}

--- ### NOTIFICATIONS ### ---

k.notification1 = 'Transaction effectuée !'
k.notification2 = 'Vous n\'avez pas assez d\'argent !'
k.notification3 = 'Vous devez renseigner un nombre supérieure ou égale à 1 !'
k.notification4 = 'Vous avez accès au stand de tire !'

--- ### POSITIONS ### ---

k.pos = {
	-- position des mannequins au stand de tir
	pedtirppa = {
		[1] = {
			positionUn = {x = 11.83999, y = -1088.36, z = 28.845, h = 161.92},
			positionDeux = {x = 12.19341, y = -1083.57, z = 28.797, h = 154.58},
			positionTrois = {x = 14.98654, y = -1079.94, z = 28.845, h = 161.71},
			positionQuatre = {x = 14.95662, y = -1075.62, z = 28.797, h = 153.85},
			positionCinq = {x = 17.66911, y = -1072.51, z = 28.797, h = 158.55},
			positionSix = {x = 17.64770, y = -1069.12, z = 28.845, h = 176.95},
		},
		[2] = {
			positionUn = {x = 13.80130, y = -1089.26, z = 28.845, h = 164.12},
			positionDeux = {x = 13.98968, y = -1085.70, z = 28.9, h = 159.48},
			positionTrois = {x = 16.75712, y = -1077.86, z = 28.797, h = 154.27},
			positionQuatre = {x = 17.29800, y = -1076.03, z = 28.797, h = 170.32},
			positionCinq = {x = 17.28654, y = -1079.74, z = 28.797, h = 153.51},
			positionSix = {x = 19.94785, y = -1069.74, z = 28.845, h = 169.27},
		},
		[3] = {
			positionUn = {x = 15.73688, y = -1089.77, z = 28.845, h = 155.92},
			positionDeux = {x = 15.91337, y = -1085.91, z = 28.797, h = 162.43},
			positionTrois = {x = 19.02970, y = -1081.01, z = 28.797, h = 155.36},
			positionQuatre = {x = 19.32555, y = -1076.58, z = 28.797, h = 154.85},
			positionCinq = {x = 21.72465, y = -1073.80, z = 28.797, h = 150.57},
			positionSix = {x = 21.69250, y = -1070.60, z = 28.845, h = 161.84},
		},
		[4] = {
			positionUn = {x = 17.67, y = -1090.43, z = 28.85, h = 159.37},
			positionDeux = {x = 17.9, y = -1086.65, z = 28.8, h = 162.34},
			positionTrois = {x = 20.08, y = -1083.63, z = 28.8, h = 163.82},
			positionQuatre = {x = 20.07, y = -1080.53, z = 28.8, h = 158.37},
			positionCinq = {x = 22.45, y = -1077.43, z = 28.8, h = 157.14},
			positionSix = {x = 22.66, y = -1073.2, z = 28.8, h = 162.59},
		},
	},
}