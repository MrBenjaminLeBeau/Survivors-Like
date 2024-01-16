extends Node2D

const ICON_PATH = "res://Graphics/"
const WEAPON_PATH = "res://Graphics/"

const UPGRADES = {
	"slimeball_projectiles1": {
		"icon": WEAPON_PATH + "Slimeball.png",
		"display_name": "Slimeball Projectiles",
		"description": "Fire 2 Total Slimeballs",
		"level": "Level: 2",
		"prerequisite": [],
		"type": "weapon"
	},
	"slimeball_projectiles2": {
		"icon": WEAPON_PATH + "Slimeball.png",
		"display_name": "Slimeball Projectiles",
		"description": "Fire 3 Total Slimeballs",
		"level": "Level: 3",
		"prerequisite": ["slimeball_projectiles1"],
		"type": "weapon"
	},
	"slimeball_projectiles3": {
		"icon": WEAPON_PATH + "Slimeball.png",
		"display_name": "Slimeball Projectiles",
		"description": "Fire 4 Total Slimeballs",
		"level": "Level: 4",
		"prerequisite": ["slimeball_projectiles2"],
		"type": "weapon"
	},
	"slimeball_range1": {
		"icon": WEAPON_PATH + "Slimeball.png",
		"display_name": "Slimeball Range",
		"description": "Increase Slimeball Range to 200",
		"level": "Level: 2",
		"prerequisite": [],
		"type": "weapon"
	},
	"slimeball_range2": {
		"icon": WEAPON_PATH + "Slimeball.png",
		"display_name": "Slimeball Range",
		"description": "Increase Slimeball Range to 300",
		"level": "Level: 3",
		"prerequisite": ["slimeball_range1"],
		"type": "weapon"
	},
	"slimeball_range3": {
		"icon": WEAPON_PATH + "Slimeball.png",
		"display_name": "Slimeball Range",
		"description": "Increase Slimeball Range to 400",
		"level": "Level: 4",
		"prerequisite": ["slimeball_range2"],
		"type": "weapon"
	},
	"slimeball_damage1": {
		"icon": WEAPON_PATH + "Slimeball.png",
		"display_name": "Slimeball Damage",
		"description": "Increase Slimeball Damage to 2",
		"level": "Level: 2",
		"prerequisite": [],
		"type": "weapon"
	},
	"slimeball_damage2": {
		"icon": WEAPON_PATH + "Slimeball.png",
		"display_name": "Slimeball Damage",
		"description": "Increase Slimeball Damage to 3",
		"level": "Level: 3",
		"prerequisite": ["slimeball_damage1"],
		"type": "weapon"
	},
	"slimeball_damage3": {
		"icon": WEAPON_PATH + "Slimeball.png",
		"display_name": "Slimeball Damage",
		"description": "Increase Slimeball Damage to 4",
		"level": "Level: 4",
		"prerequisite": ["slimeball_damage2"],
		"type": "weapon"
	},
	"slimeball_speed1": {
		"icon": WEAPON_PATH + "Slimeball.png",
		"display_name": "Slimeball Speed",
		"description": "Increase Slimeball Speed to 300",
		"level": "Level: 2",
		"prerequisite": [],
		"type": "weapon"
	},
	"slimeball_speed2": {
		"icon": WEAPON_PATH + "Slimeball.png",
		"display_name": "Slimeball Speed",
		"description": "Increase Slimeball Speed to 400",
		"level": "Level: 3",
		"prerequisite": ["slimeball_speed1"],
		"type": "weapon"
	},
	"slimeball_speed3": {
		"icon": WEAPON_PATH + "Slimeball.png",
		"display_name": "Slimeball Speed",
		"description": "Increase Slimeball Speed to 500",
		"level": "Level: 4",
		"prerequisite": ["slimeball_speed2"],
		"type": "weapon"
	},
	"slimeball_rate1": {
		"icon": WEAPON_PATH + "Slimeball.png",
		"display_name": "Slimeball Rate of Fire",
		"description": "Increase Slimeball Rate of Fire",
		"level": "Level: 2",
		"prerequisite": [],
		"type": "weapon"
	},
	"slimeball_rate2": {
		"icon": WEAPON_PATH + "Slimeball.png",
		"display_name": "Slimeball Rate of Fire",
		"description": "Increase Slimeball Rate of Fire",
		"level": "Level: 3",
		"prerequisite": ["slimeball_rate1"],
		"type": "weapon"
	},
	"slimeball_rate3": {
		"icon": WEAPON_PATH + "Slimeball.png",
		"display_name": "Slimeball Rate of Fire",
		"description": "Increase Slimeball Rate of Fire",
		"level": "Level: 4",
		"prerequisite": ["slimeball_rate2"],
		"type": "weapon"
	},
	"slimeball_bounce1": {
		"icon": WEAPON_PATH + "Slimeball.png",
		"display_name": "Slimeball Bounce",
		"description": "Slimeballs Will Bounce 1 Time",
		"level": "Level: 2",
		"prerequisite": [],
		"type": "weapon"
	},
	"slimeball_bounce2": {
		"icon": WEAPON_PATH + "Slimeball.png",
		"display_name": "Slimeball Bounce",
		"description": "Slimeballs Will Bounce 2 Times",
		"level": "Level: 3",
		"prerequisite": ["slimeball_bounce1"],
		"type": "weapon"
	},
	"slimeball_bounce3": {
		"icon": WEAPON_PATH + "Slimeball.png",
		"display_name": "Slimeball Bounce",
		"description": "Slimeballs Will Bounce 3 Times",
		"level": "Level: 4",
		"prerequisite": ["slimeball_bounce2"],
		"type": "weapon"
	},
	
	"food": {
		"icon": WEAPON_PATH + "Slimeball.png",
		"display_name": "Food",
		"description": "Restores 20 HP",
		"level": "N/A",
		"prerequisite": [],
		"type": "item"
	}
}
