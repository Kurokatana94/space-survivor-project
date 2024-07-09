extends Node2D

@export var g72r_carbine: PackedScene
@export var tags: Array[String]

var damage_range: Array[float] = [90.0, 110.0] #damage range for base level weapon
var damage_multiplier:float = 1.0
var type: String = "skill"
var ability_name: String = "G-72R"
var description: String = "Piercing ammo shooting carbine"
const MAX_LEVEL: int = 5
var current_level: int = 0

func _ready():
	instantiate_gun()

func level_up():
	if current_level < MAX_LEVEL:
		current_level += 1
	instantiate_gun()

func instantiate_gun():
	var new_carbine = g72r_carbine.instantiate()
	new_carbine.global_position = get_parent().global_position
	add_child(new_carbine)
	new_carbine.damage_range = damage_range

	match current_level:
		0:
			new_carbine.damage_multiplier = damage_multiplier
		1:
			new_carbine.damage_multiplier = damage_multiplier + .25
		2:
			new_carbine.damage_multiplier = damage_multiplier + .25
			new_carbine.shooting_cd.wait_time -= .5
			if new_carbine.shooting_cd.is_stopped():
				new_carbine.shooting_cd.start()
			else:
				new_carbine.shooting_cd.stop()
				new_carbine.shooting_cd.start()
		3:
			new_carbine.damage_multiplier = damage_multiplier + .75
			new_carbine.shooting_cd.wait_time -= .5
			if new_carbine.shooting_cd.is_stopped():
				new_carbine.shooting_cd.start()
			else:
				new_carbine.shooting_cd.stop()
				new_carbine.shooting_cd.start()
		4:
			new_carbine.damage_multiplier = damage_multiplier + .75
			new_carbine.shooting_cd.wait_time -= 1
			if new_carbine.shooting_cd.is_stopped():
				new_carbine.shooting_cd.start()
			else:
				new_carbine.shooting_cd.stop()
				new_carbine.shooting_cd.start()
		5:
			new_carbine.damage_multiplier = damage_multiplier + 3.0
			new_carbine.shooting_cd.wait_time -= 1
			if new_carbine.shooting_cd.is_stopped():
				new_carbine.shooting_cd.start()
			else:
				new_carbine.shooting_cd.stop()
				new_carbine.shooting_cd.start()
