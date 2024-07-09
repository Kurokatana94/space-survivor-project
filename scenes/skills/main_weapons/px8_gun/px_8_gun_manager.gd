extends Node

@export var px8_gun: PackedScene
@export var tags: Array[String]

var damage_range: Array[float] = [17.0, 34.0] #damage range for base level weapon
var damage_multiplier: float = 1.0
var type: String = "skill"
var ability_name: String = "PX8"
var description: String = "Barrage shooting pistol"
const MAX_LEVEL: int = 5
var current_level: int = 0

func _ready():
	instantiate_gun()

func level_up():
	if current_level < MAX_LEVEL:
		current_level += 1
	instantiate_gun()

func instantiate_gun():
	var new_gun = px8_gun.instantiate()
	new_gun.global_position = get_parent().global_position
	add_child(new_gun)
	new_gun.damage_range = damage_range

	match current_level:
		0:
			new_gun.damage_multiplier = damage_multiplier
		1:
			new_gun.damage_multiplier = damage_multiplier + .25
		2:
			new_gun.damage_multiplier += .25
			new_gun.shooting_cd.wait_time -= 0.1
			if new_gun.shooting_cd.is_stopped():
				new_gun.shooting_cd.start()
			else:
				new_gun.shooting_cd.stop()
				new_gun.shooting_cd.start()
		3:
			new_gun.damage_multiplier = damage_multiplier + .25
			new_gun.base_barrage_count += 1
			new_gun.current_barrage_count = new_gun.base_barrage_count
			new_gun.shooting_cd.wait_time -= 0.1
			if new_gun.shooting_cd.is_stopped():
				new_gun.shooting_cd.start()
			else:
				new_gun.shooting_cd.stop()
				new_gun.shooting_cd.start()
		4:
			new_gun.damage_multiplier = damage_multiplier + .5
			new_gun.base_barrage_count += 1
			new_gun.current_barrage_count = new_gun.base_barrage_count
			new_gun.shooting_cd.wait_time -= 0.1
			if new_gun.shooting_cd.is_stopped():
				new_gun.shooting_cd.start()
			else:
				new_gun.shooting_cd.stop()
				new_gun.shooting_cd.start()
		5:
			new_gun.damage_multiplier = damage_multiplier + .5
			new_gun.base_barrage_count += 2
			new_gun.current_barrage_count = new_gun.base_barrage_count
			new_gun.shooting_cd.wait_time -= 0.1
			if new_gun.shooting_cd.is_stopped():
				new_gun.shooting_cd.start()
			else:
				new_gun.shooting_cd.stop()
				new_gun.shooting_cd.start()
