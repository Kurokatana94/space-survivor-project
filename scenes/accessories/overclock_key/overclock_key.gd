extends Node

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")

var damage_multiplier: float
var deployment_cd: float

func _ready():
	call_deferred("update_bonuses")

func update_bonuses():
	print(deployment_cd)
	print(damage_multiplier)
	var weapon_list: Array = player.weapons_node.get_children()
	for i in weapon_list.size():
		for j in weapon_list[i].tags.size():
			if weapon_list[i].tags[j] == "turret":
				weapon_list[i].damage_multiplier += damage_multiplier
				weapon_list[i].base_deployment_cd -= weapon_list[i].base_deployment_cd * deployment_cd
				print(weapon_list[i].base_deployment_cd)
