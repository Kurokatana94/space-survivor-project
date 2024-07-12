extends CharacterBody2D

@export var projectile: PackedScene

@onready var enemy_aim_bot: Area2D = $EnemyAimBot
@onready var shooting_cd: Timer = $ShootingCD
@onready var shooting_point = $ShootingPoint
@onready var shooting_barrage_delay: Timer = $ShootingBarrageDelay
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")

var damage_range: Array[float]
var damage_multiplier: float
var tags: Array[String]
var base_explosion_radius: float
var first_shot: bool = true
var base_barrage_count: int = 1
var current_barrage_count: int
var speed: int

const ACCELERATION_SMOOTHING = 15

func _ready():
	speed = player.max_speed
	current_barrage_count = base_barrage_count

func _physics_process(delta):
	follow_player(delta)
	check_closest_target()
	if first_shot:
		first_shot = false
		_on_shooting_cd_timeout()

func _on_shooting_cd_timeout():
	shoot()

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
	else:
		return

func shoot():
	var new_projectile = projectile.instantiate()
	add_child(new_projectile)
	new_projectile.get_child(0).global_position = shooting_point.global_position
	new_projectile.get_child(0).global_rotation = shooting_point.global_rotation

	new_projectile.damage_range = damage_range
	new_projectile.damage_multiplier = damage_multiplier
	new_projectile.base_explosion_radius = base_explosion_radius
	new_projectile.tags = tags
	
	if base_barrage_count > 1:
		shooting_barrage_delay.start()
		current_barrage_count -= 1

func _on_shooting_barrage_delay_timeout():
	if current_barrage_count > 0:
		shoot()
	else:
		current_barrage_count = base_barrage_count
		shooting_cd.start() # Restart the shooting cooldown if the barrage is done (maybe remove this line if you want to keep the cooldown running)
		shooting_barrage_delay.stop()

func follow_player(delta):
	var direction = player.global_position - global_position
	var target_position = player.global_position - direction.normalized() * 40
	global_position = global_position.lerp(target_position, delta * speed / ACCELERATION_SMOOTHING)
	
	var avoidance_radius: float = 30.0

	avoid_other_drones(avoidance_radius, delta)

	move_and_slide()

func avoid_other_drones(avoidance_radius: float, delta): #I might change this by folloing the node which is instantiated in instead of player nad the making the node follow the player
	var drones = get_tree().get_nodes_in_group("454_ss_drone")
	for drone in drones:
		if drone != self:
			var distance = global_position.distance_to(drone.global_position)
			if distance < avoidance_radius:
				var avoidance_direction = global_position - drone.global_position

				global_position = global_position.lerp(global_position + avoidance_direction, delta * speed / ACCELERATION_SMOOTHING)

				move_and_slide()
