extends Node2D

@export var _454_ss_drone: PackedScene
@export var tags: Array[String]

var damage_range: Array[float] = [35.0, 35.0] #damage range for base level weapon
var damage_multiplier: float = 1.0
var base_explosion_radius: float = 10.0
var base_deployment_cd: float = 1.0 #Had to add this to make the overclock key work even thou this var is not used here. I don't like it but it works
var deployment_cd: float = 1.0 #same as above
var type = "skill"
var ability_name = "454-SS \"Sparky Swarm\""
var description = "A drone that shoots bullets and follows you"

const MAX_LEVEL = 5
var current_level = 0

func _ready():
	call_deferred("instantiate_drone")

func instantiate_drone():
	var new_drone = _454_ss_drone.instantiate()
	new_drone.global_position = get_random_location_around_player()
	add_child(new_drone)
	new_drone.damage_range = damage_range
	new_drone.tags = tags

	match current_level:
		0:
			new_drone.damage_multiplier = damage_multiplier
			new_drone.base_explosion_radius = base_explosion_radius
		1:
			new_drone.damage_multiplier = damage_multiplier
			new_drone.base_explosion_radius = base_explosion_radius
			instantiate_extra_drone(new_drone.damage_multiplier, new_drone.shooting_cd.wait_time, 1, new_drone.base_explosion_radius)
		2:
			new_drone.shooting_cd.wait_time -= .5
			new_drone.damage_multiplier = damage_multiplier
			new_drone.base_explosion_radius = base_explosion_radius
			instantiate_extra_drone(new_drone.damage_multiplier, new_drone.shooting_cd.wait_time, 1, new_drone.base_explosion_radius)
			if new_drone.shooting_cd.is_stopped():
				new_drone.shooting_cd.start()
			else:
				new_drone.shooting_cd.stop()
				new_drone.shooting_cd.start()
		3:
			new_drone.shooting_cd.wait_time -= .5
			new_drone.damage_multiplier = damage_multiplier
			new_drone.base_explosion_radius = base_explosion_radius
			instantiate_extra_drone(new_drone.damage_multiplier, new_drone.shooting_cd.wait_time, 2, new_drone.base_explosion_radius)
			if new_drone.shooting_cd.is_stopped():
				new_drone.shooting_cd.start()
			else:
				new_drone.shooting_cd.stop()
				new_drone.shooting_cd.start()
		4:
			new_drone.base_barrage_count = 2
			new_drone.shooting_cd.wait_time -= .5
			new_drone.damage_multiplier = damage_multiplier
			new_drone.base_explosion_radius = base_explosion_radius
			instantiate_extra_drone(new_drone.damage_multiplier, new_drone.shooting_cd.wait_time, 2, new_drone.base_explosion_radius)
			instantiate_extra_drone(new_drone.damage_multiplier, new_drone.shooting_cd.wait_time, 2, new_drone.base_explosion_radius)
			if new_drone.shooting_cd.is_stopped():
				new_drone.shooting_cd.start()
			else:
				new_drone.shooting_cd.stop()
				new_drone.shooting_cd.start()
		5:
			new_drone.base_barrage_count = 2
			new_drone.shooting_cd.wait_time -= 1
			new_drone.damage_multiplier = damage_multiplier * 2
			new_drone.base_explosion_radius = base_explosion_radius
			instantiate_extra_drone(new_drone.damage_multiplier, new_drone.shooting_cd.wait_time, 2, new_drone.base_explosion_radius)
			instantiate_extra_drone(new_drone.damage_multiplier, new_drone.shooting_cd.wait_time, 2, new_drone.base_explosion_radius)
			if new_drone.shooting_cd.is_stopped():
				new_drone.shooting_cd.start()
			else:
				new_drone.shooting_cd.stop()
				new_drone.shooting_cd.start()

func get_random_location_around_player() -> Vector2:
	var player_position = get_tree().get_first_node_in_group("player").global_position
	var random_angle = randf_range(0, 2 * PI)
	var offset = Vector2(cos(random_angle), sin(random_angle)) * 10
	var random_location = player_position + offset
	return random_location

func instantiate_extra_drone(current_damage_multiplier: float, current_shooting_cd: float, current_barrage_count: int, current_explosion_radius: float):
	var new_drone = _454_ss_drone.instantiate()
	new_drone.global_position = get_random_location_around_player()
	add_child(new_drone)
	new_drone.damage_range = damage_range
	new_drone.tags = tags
	new_drone.damage_multiplier = current_damage_multiplier
	new_drone.shooting_cd.wait_time = current_shooting_cd
	new_drone.base_barrage_count = current_barrage_count
	new_drone.base_explosion_radius = current_explosion_radius

	if new_drone.shooting_cd.is_stopped():
		new_drone.shooting_cd.start()
	else:
		new_drone.shooting_cd.stop()
		new_drone.shooting_cd.start()
