extends Node2D

@export var plasma_charger_xc_01: PackedScene
@export var tags: Array[String]

var damage_range: Array[float] = [8.0, 11.0] #damage range for base level weapon
var damage_multiplier: float = 1.0
var critical_chance: float = 0.0
var critical_damage: float = 2.0
var dot_tic_cd: float = .8
var reload_speed: float = 5
var mag_size: int = 5
var base_range: float = 300
var type = "skill"
var ability_name = "Plasma Charger XC-01"
var description = "A plasma gun that shoots plasma orbs that link to enemies dealing damage over time"
const MAX_LEVEL = 5
var current_level = 0

func _ready():
	call_deferred("instantiate_plasma_charger_xc_01")

func instantiate_plasma_charger_xc_01():
	var new_plasma_charger_xc_01 = plasma_charger_xc_01.instantiate()
	new_plasma_charger_xc_01.global_position = get_parent().global_position
	add_child(new_plasma_charger_xc_01)
	new_plasma_charger_xc_01.damage_range = damage_range
	new_plasma_charger_xc_01.max_range = base_range
	new_plasma_charger_xc_01.dot_tic_cd = dot_tic_cd
	new_plasma_charger_xc_01.tags = tags
	new_plasma_charger_xc_01.reload_cd.wait_time = reload_speed
	new_plasma_charger_xc_01.mag_size = mag_size
	match current_level:
		0:
			new_plasma_charger_xc_01.damage_multiplier = damage_multiplier
		1:
			new_plasma_charger_xc_01.damage_multiplier = damage_multiplier
			new_plasma_charger_xc_01.reload_cd.wait_time -= 1
		2:
			new_plasma_charger_xc_01.damage_multiplier = damage_multiplier
			new_plasma_charger_xc_01.reload_cd.wait_time -= 1
			new_plasma_charger_xc_01.mag_size += int(mag_size * .5)
		3:
			new_plasma_charger_xc_01.damage_multiplier += damage_multiplier * .5
			new_plasma_charger_xc_01.reload_cd.wait_time -= 1
			new_plasma_charger_xc_01.mag_size += int(mag_size * .5)
		4:
			new_plasma_charger_xc_01.damage_multiplier += damage_multiplier * .5
			new_plasma_charger_xc_01.reload_cd.wait_time -= 1
			new_plasma_charger_xc_01.mag_size += mag_size
		5:
			new_plasma_charger_xc_01.damage_multiplier += damage_multiplier
			new_plasma_charger_xc_01.reload_cd.wait_time -= 3
			new_plasma_charger_xc_01.mag_size += mag_size

