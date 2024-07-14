extends Area2D

@export var px8_bullet: PackedScene

@onready var shooting_cd: Timer = $ShootingCD
@onready var shooting_barrage_delay: Timer = $ShootingBarrageDelay
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")

var damage_range: Array[float]
var damage_multiplier: float
var tags: Array[String]
var critical_chance: float
var critical_damage: float
var first_shot: bool = true
var base_barrage_count: int = 2
var current_barrage_count: int
func _ready():
	current_barrage_count = base_barrage_count

func _physics_process(delta):
	if first_shot:
		first_shot = false
		_on_shooting_cd_timeout()
	# Update the shooting point position to follow the direction the player is facing
	if player.get_movement_vector() != Vector2.ZERO:
		global_rotation = player.get_movement_vector().normalized().angle()
		

func _on_shooting_cd_timeout():
	shooting_cd.stop()
	shoot()


func shoot():
	var bullet = px8_bullet.instantiate()
	bullet.global_position = $ShootingPoint.global_position
	bullet.global_rotation = $ShootingPoint.global_rotation
	
	add_child(bullet)

	bullet.tags = tags
	bullet.damage_range = damage_range
	bullet.damage_multiplier = damage_multiplier
	shooting_barrage_delay.start()
	current_barrage_count -= 1


func _on_shooting_barrage_delay_timeout():
	if current_barrage_count > 0:
		shoot()
	else:
		current_barrage_count = base_barrage_count
		shooting_cd.start() # Restart the shooting cooldown if the barrage is done (maybe remove this line if you want to keep the cooldown running)
		shooting_barrage_delay.stop()
