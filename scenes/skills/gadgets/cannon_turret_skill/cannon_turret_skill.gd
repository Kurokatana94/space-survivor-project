extends StaticBody2D

@export var explosive_bullet_manager: PackedScene
@onready var enemy_aim_bot: Area2D = $EnemyAimBot
@onready var skill_duration: Timer = $SkillDuration
@onready var shooting_cd: Timer = $ShootingCD

var base_skill_duration: float
var base_shooting_cd: float
var damage_range: Array[float]
var damage_multiplier: float = 1.0
var base_explosion_radius: float
var first_shot: bool = true
var tags: Array[String]

func _ready():
	base_shooting_cd = shooting_cd.wait_time
	base_skill_duration = skill_duration.wait_time

func _physics_process(delta): 
	check_closest_target() #Need to implement a way to rotate at a stable speed if it needs a 180 turn-around
	if first_shot:
		shoot()
		first_shot = false


#shoot cannonballs on CD timeout
func _on_shooting_cd_timeout():
	shoot()

func _on_skill_duration_timeout():
	queue_free()

func check_closest_target():
	var enemies_in_range = enemy_aim_bot.get_overlapping_areas()
	if enemies_in_range.size() > 0:
		var target = enemies_in_range[0]
		look_at(target.global_position)
	else:
		return

func shoot():
	var new_explosive_bullet_manager = explosive_bullet_manager.instantiate()
	new_explosive_bullet_manager.get_child(0).global_position = $%ShootingPoint.global_position
	new_explosive_bullet_manager.get_child(0).global_rotation = $%ShootingPoint.global_rotation
	get_parent().add_child(new_explosive_bullet_manager)
	new_explosive_bullet_manager.damage_range = damage_range
	new_explosive_bullet_manager.damage_multiplier = damage_multiplier
	new_explosive_bullet_manager.base_explosion_radius = base_explosion_radius
	new_explosive_bullet_manager.tags = tags

	
