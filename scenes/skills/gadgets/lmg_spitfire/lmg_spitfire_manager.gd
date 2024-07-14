extends Node2D

@export var lmg_spitfire: PackedScene
@export var tags: Array[String]

var damage_range: Array[float] = [11.0, 18.0] #damage range for base level weapon
var damage_multiplier: float = 1.0
var critical_chance: float = 0.0
var critical_damage: float = 2.0
var reload_speed: float = 9
var mag_size: int = 100
var base_range: float = 150
var type = "skill"
var ability_name = "LMG \"Spitfire\""
var description = "A mini-gun that shoots bullets at a high rate"
const MAX_LEVEL = 5
var current_level = 0

func _ready():
	call_deferred("instantiate_lmg_spitfire")

func instantiate_lmg_spitfire():
	var new_lmg_spitfire = lmg_spitfire.instantiate()
	new_lmg_spitfire.global_position = get_parent().global_position
	add_child(new_lmg_spitfire)
	new_lmg_spitfire.damage_range = damage_range
	new_lmg_spitfire.max_range = base_range
	new_lmg_spitfire.tags = tags
	new_lmg_spitfire.reload_cd.wait_time = reload_speed
	new_lmg_spitfire.mag_size = mag_size
	match current_level:
		0:
			new_lmg_spitfire.damage_multiplier = damage_multiplier
		1:
			new_lmg_spitfire.damage_multiplier = damage_multiplier
			new_lmg_spitfire.reload_cd.wait_time -= 1
		2:
			new_lmg_spitfire.damage_multiplier = damage_multiplier
			new_lmg_spitfire.reload_cd.wait_time -= 1
			new_lmg_spitfire.mag_size += mag_size * .5
		3:
			new_lmg_spitfire.damage_multiplier += damage_multiplier * .5
			new_lmg_spitfire.reload_cd.wait_time -= 1
			new_lmg_spitfire.mag_size += mag_size * .5
		4:
			new_lmg_spitfire.damage_multiplier += damage_multiplier * .5
			new_lmg_spitfire.reload_cd.wait_time -= 1
			new_lmg_spitfire.mag_size += mag_size
		5:
			new_lmg_spitfire.damage_multiplier += damage_multiplier
			new_lmg_spitfire.reload_cd.wait_time -= 3
			new_lmg_spitfire.mag_size += mag_size


