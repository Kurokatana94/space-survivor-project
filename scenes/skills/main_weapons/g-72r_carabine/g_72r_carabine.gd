extends Area2D

@export var g_72r_bullet: PackedScene

@onready var shooting_cd: Timer = $ShootingCD
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")

var damage_range: Array[float]
var damage_multiplier: float = 1.0
var first_shot: bool = true

func _physics_process(delta):
	check_highest_health()
	if first_shot:
		first_shot = false
		_on_shooting_cd_timeout()

func _on_shooting_cd_timeout():
	shoot()

func shoot():
	var bullet = g_72r_bullet.instantiate()
	bullet.global_position = $ShootingPoint.global_position
	bullet.global_rotation = $ShootingPoint.global_rotation
	
	add_child(bullet)

	bullet.damage_range = damage_range
	bullet.damage_multiplier = damage_multiplier

func check_highest_health():
	var enemies_in_range = get_overlapping_areas()
	var highest_health: int = 0
	var target

	if enemies_in_range == null || enemies_in_range.size() == 0:
		return

	for enemy in enemies_in_range:
		var enemy_health = enemy.health_system_component.current_health

		if enemy_health > highest_health:
			highest_health = enemy_health
			target = enemy
		
		if enemy_health == highest_health:
			if enemy.global_position.distance_to(player.global_position) < target.global_position.distance_to(player.global_position):
				target = enemy
	
	if target != null:
		look_at(target.global_position)

	

