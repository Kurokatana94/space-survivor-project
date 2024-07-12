extends Area2D

@export var sparka_12_bullet: PackedScene

@onready var shooting_cd: Timer = $ShootingCD
@onready var shooting_point = $ShootingPoint
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")

var damage_range: Array[float]
var damage_multiplier: float
var tags: Array[String]
var critical_chance: float
var critical_damage: float
var pallets_amount: int
var reload_speed: float
var max_range: float
var first_shot: bool = true

func _physics_process(delta):
	check_closest_target()
	if first_shot:
		first_shot = false
		_on_shooting_cd_timeout()

func _on_shooting_cd_timeout():
	shoot()

func check_closest_target():
	var enemies_in_range = get_overlapping_areas()
	if enemies_in_range.size() > 0:
		var closest_enemy = enemies_in_range[0]
		var closest_distance = global_position.distance_to(closest_enemy.global_position)
		for enemy in enemies_in_range:
			var distance = global_position.distance_to(enemy.global_position)
			if distance < closest_distance:
				closest_enemy = enemy
				closest_distance = distance
		look_at(closest_enemy.global_position)
	else:
		return

func shoot():
	for i in pallets_amount:
		var bullet = sparka_12_bullet.instantiate()
		bullet.global_position = $ShootingPoint.global_position
		bullet.global_rotation = $ShootingPoint.global_rotation + deg_to_rad(randf_range(-15, 15))
		
		add_child(bullet)

		bullet.max_distance = max_range
		bullet.damage_range = damage_range
		bullet.damage_multiplier = damage_multiplier
		bullet.tags = tags
		bullet.critical_chance = critical_chance
		bullet.critical_damage = critical_damage