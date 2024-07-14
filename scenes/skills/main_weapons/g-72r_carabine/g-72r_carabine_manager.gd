extends Node2D

@export var g72r_carbine: PackedScene
@export var tags: Array[String]

var damage_range: Array[float] = [90.0, 110.0] #damage range for base level weapon
var damage_multiplier:float = 1.0
var critical_chance: float = 0.0
var critical_damage: float = 2.0
var reload_speed: float = 4
var mag_size: int = 1
var type: String = "skill"
var ability_name: String = "G-72R"
var description: String = "Piercing ammo shooting carbine"
const MAX_LEVEL: int = 5
var current_level: int = 0

func _ready():
	call_deferred("instantiate_gun")

func level_up():
	if current_level < MAX_LEVEL:
		current_level += 1
	instantiate_gun()

func instantiate_gun():
	var new_carbine = g72r_carbine.instantiate()
	new_carbine.global_position = get_parent().global_position
	add_child(new_carbine)
	new_carbine.damage_range = damage_range
	new_carbine.tags = tags
	new_carbine.reload_cd.wait_time = reload_speed
	new_carbine.mag_size = mag_size

	match current_level:
		0:
			new_carbine.damage_multiplier = damage_multiplier
			new_carbine.critical_chance = critical_chance
			new_carbine.critical_damage = critical_damage
		1:
			new_carbine.damage_multiplier = damage_multiplier
			new_carbine.critical_chance = critical_chance
			new_carbine.critical_damage = critical_damage
			new_carbine.reload_cd.wait_time -= .5
		2:
			new_carbine.damage_multiplier = damage_multiplier + .5
			new_carbine.critical_chance = critical_chance
			new_carbine.critical_damage = critical_damage
			new_carbine.reload_cd.wait_time -= .5
		3:
			new_carbine.damage_multiplier = damage_multiplier + .5
			new_carbine.critical_chance = critical_chance
			new_carbine.critical_damage = critical_damage
			new_carbine.reload_cd.wait_time -= 1.5
		4:
			new_carbine.damage_multiplier = damage_multiplier + 1.0
			new_carbine.critical_chance = critical_chance
			new_carbine.critical_damage = critical_damage
			new_carbine.reload_cd.wait_time -= 1.5
		5:
			new_carbine.damage_multiplier = damage_multiplier + 2.0
			new_carbine.critical_chance = critical_chance
			new_carbine.critical_damage = critical_damage
			new_carbine.reload_cd.wait_time -= 1.5

