extends Node2D

@export var explosive_grenade: PackedScene

@onready var deployment_cd: Timer = $DeploymentCD
@onready var enemy_aim_bot: Area2D = $EnemyAimBot
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")

var damage_range: Array[float]
var damage_multiplier: float
var base_explosion_radius: float
var grenades_quantity: int
var throw_distance_radius: float = 350
var distance_to_target: float
var first_deployment: bool = true
var tags: Array[String]

func _process(delta):
	set_distance_to_target()

	if first_deployment:
		instantiate_grenades()
		first_deployment = false

func instantiate_grenades():
	print("Instantiating grenades")
	for i in grenades_quantity:
		var new_grenade = explosive_grenade.instantiate()
		new_grenade.get_child(0).global_position = global_position
		new_grenade.get_child(0).global_rotation = global_rotation
		add_child(new_grenade)
		new_grenade.get_child(0).distance_to_target = distance_to_target
		new_grenade.damage_range = damage_range
		new_grenade.damage_multiplier = damage_multiplier
		new_grenade.base_explosion_radius = base_explosion_radius
		new_grenade.tags = tags

func _on_deployment_cd_timeout():
	call_deferred("instantiate_grenades")

func check_closest_target():
	var enemies_in_range = enemy_aim_bot.get_overlapping_areas()
	if enemies_in_range.size() > 0:
		var closest_enemy = enemies_in_range[0]
		var closest_distance = global_position.distance_to(closest_enemy.global_position)
		for enemy in enemies_in_range:
			var distance = global_position.distance_to(enemy.global_position)
			if distance < closest_distance:
				closest_enemy = enemy
				closest_distance = distance
		look_at(closest_enemy.global_position)
		if closest_distance >= throw_distance_radius:
			return throw_distance_radius
		else:
			return closest_distance
		return closest_distance
	else:
		return get_random_distance()

func get_random_distance():
	return randf_range(150, 250)
 

func set_distance_to_target():
	distance_to_target = check_closest_target()
	distance_to_target -= distance_to_target * .3
	if distance_to_target < 0:
		distance_to_target = 0
	elif distance_to_target > throw_distance_radius:
		distance_to_target = throw_distance_radius