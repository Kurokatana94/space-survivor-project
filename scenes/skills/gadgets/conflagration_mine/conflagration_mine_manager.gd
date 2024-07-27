extends Node2D

@export var conflagration_mine_skill: PackedScene
@export var tags: Array[String]

var damage_range: Array[float] = [120.0, 120.0] #damage range for base level weapon
var damage_multiplier: float = 1.0
var base_explosion_radius: float = 10.0
var mines_quantity: int = 6
var type = "skill"
var ability_name = "Conflagration Mine"
var description = "A mine that explodes when an enemy steps on it"
const MAX_LEVEL = 5
var current_level = 5

var first_deployment = true

func _process(delta):
	if first_deployment:
		instantiate_mine_skill()
		first_deployment = false

func instantiate_mine_skill():
	var new_mine = conflagration_mine_skill.instantiate()
	new_mine.global_position = global_position
	add_child(new_mine)
	new_mine.damage_range = damage_range
	new_mine.tags = tags
	match current_level:
		0:
			new_mine.damage_multiplier = damage_multiplier
			new_mine.base_explosion_radius = base_explosion_radius
			new_mine.mines_quantity = mines_quantity
		1:
			new_mine.damage_multiplier = damage_multiplier
			new_mine.base_explosion_radius = base_explosion_radius
			new_mine.mines_quantity = mines_quantity
			new_mine.deployment_cd.wait_time -= 2.0
			if new_mine.deployment_cd.is_stopped():
				new_mine.deployment_cd.start()
			else:
				new_mine.deployment_cd.stop()
				new_mine.deployment_cd.start()
		2:
			new_mine.damage_multiplier = damage_multiplier
			new_mine.base_explosion_radius = base_explosion_radius * 1.25
			new_mine.mines_quantity = mines_quantity
			new_mine.deployment_cd.wait_time -= 2.0
			if new_mine.deployment_cd.is_stopped():
				new_mine.deployment_cd.start()
			else:
				new_mine.deployment_cd.stop()
				new_mine.deployment_cd.start()
		3:
			new_mine.damage_multiplier = damage_multiplier
			new_mine.base_explosion_radius = base_explosion_radius * 1.25
			new_mine.mines_quantity = mines_quantity + 2
			new_mine.deployment_cd.wait_time -= 2.0
			if new_mine.deployment_cd.is_stopped():
				new_mine.deployment_cd.start()
			else:
				new_mine.deployment_cd.stop()
				new_mine.deployment_cd.start()
		4:
			new_mine.damage_multiplier = damage_multiplier
			new_mine.base_explosion_radius = base_explosion_radius * 1.25
			new_mine.mines_quantity = mines_quantity + 2
			new_mine.deployment_cd.wait_time -= 2.0
			if new_mine.deployment_cd.is_stopped():
				new_mine.deployment_cd.start()
			else:
				new_mine.deployment_cd.stop()
				new_mine.deployment_cd.start()
		5:
			new_mine.damage_multiplier = damage_multiplier
			new_mine.base_explosion_radius = base_explosion_radius * 1.75
			new_mine.mines_quantity = mines_quantity + 2
			new_mine.deployment_cd.wait_time -= 3.0
			if new_mine.deployment_cd.is_stopped():
				new_mine.deployment_cd.start()
			else:
				new_mine.deployment_cd.stop()
				new_mine.deployment_cd.start()
