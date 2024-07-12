extends Node

@export var cannon_turret_skill: PackedScene
@export var tags: Array[String]
@onready var deployment_cd = $DeploymentCD.wait_time

var damage_range: Array[float] = [300.0, 300.0] #damage range for base level weapon
var damage_multiplier:float = 1.0
var base_explosion_radius: float = 40.0
var type = "skill"
var ability_name = "Cannon Turret"
var description = "Deploy and auto-shoots explosive ammos"
const MAX_LEVEL = 5
var current_level = 0

var base_deployment_cd
var first_deployment = false

func _ready():
	base_deployment_cd = deployment_cd

func _process(delta):
	if !first_deployment:
		instantiate_cannon_turret()
		$DeploymentCD.wait_time = base_deployment_cd
		first_deployment = true

func level_up():
	if current_level < MAX_LEVEL:
		current_level += 1
	
	$CannonTurretSkill.queue_free()

	instantiate_cannon_turret()

func _on_deployment_cd_timeout():
	instantiate_cannon_turret()


func instantiate_cannon_turret():
	var new_cannon_turret = cannon_turret_skill.instantiate()
	var spawn_node = get_tree().get_first_node_in_group("player").weapons_node
	new_cannon_turret.damage_range = damage_range
	new_cannon_turret.tags = tags

	match current_level:
		0:
			new_cannon_turret.damage_multiplier = damage_multiplier
			new_cannon_turret.base_explosion_radius = base_explosion_radius

			spawn_node.add_child(new_cannon_turret)
			new_cannon_turret.global_position = spawn_node.global_position
		1:
			new_cannon_turret.damage_multiplier = damage_multiplier
			new_cannon_turret.base_explosion_radius = base_explosion_radius * 1.4

			spawn_node.add_child(new_cannon_turret)
			new_cannon_turret.global_position = spawn_node.global_position			
		2:
			new_cannon_turret.damage_multiplier = damage_multiplier
			new_cannon_turret.base_explosion_radius = base_explosion_radius * 1.4

			spawn_node.add_child(new_cannon_turret)
			new_cannon_turret.global_position = spawn_node.global_position
			new_cannon_turret.skill_duration.wait_time += 2.5
			reset_turret_cd(new_cannon_turret)
		3:
			new_cannon_turret.damage_multiplier = damage_multiplier
			new_cannon_turret.base_explosion_radius = base_explosion_radius * 1.4

			spawn_node.add_child(new_cannon_turret)
			new_cannon_turret.global_position = spawn_node.global_position
			new_cannon_turret.skill_duration.wait_time += 2.5
			new_cannon_turret.shooting_cd.wait_time = new_cannon_turret.shooting_cd.wait_time - 0.5
	
			reset_turret_cd(new_cannon_turret)
		4:
			new_cannon_turret.damage_multiplier = damage_multiplier
			new_cannon_turret.base_explosion_radius = base_explosion_radius * 1.8

			spawn_node.add_child(new_cannon_turret)
			new_cannon_turret.global_position = spawn_node.global_position
			new_cannon_turret.skill_duration.wait_time += 2.5
			new_cannon_turret.shooting_cd.wait_time = new_cannon_turret.shooting_cd.wait_time - 0.5
			
			reset_turret_cd(new_cannon_turret)
		5:
			new_cannon_turret.damage_multiplier = damage_multiplier
			new_cannon_turret.base_explosion_radius = base_explosion_radius * 1.8

			spawn_node.add_child(new_cannon_turret)
			new_cannon_turret.global_position = spawn_node.global_position
			new_cannon_turret.skill_duration.wait_time += 5.0
			new_cannon_turret.shooting_cd.wait_time = new_cannon_turret.shooting_cd.wait_time - 1.0
			
			reset_turret_cd(new_cannon_turret)

func reset_turret_cd(new_cannon_turret):
		if new_cannon_turret.skill_duration.is_stopped():
			new_cannon_turret.skill_duration.start()
		else:
			new_cannon_turret.skill_duration.stop()
			new_cannon_turret.skill_duration.start()
	
		if new_cannon_turret.shooting_cd.is_stopped():
			new_cannon_turret.shooting_cd.start()
		else:
			new_cannon_turret.shooting_cd.stop()
			new_cannon_turret.shooting_cd.start()
