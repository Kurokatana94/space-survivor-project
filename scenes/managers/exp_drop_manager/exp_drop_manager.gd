extends Node

@export var exp_crystal_1: PackedScene
@export_range(0, 1) var drop_chance: float = .5
@onready var pickable_items_node = get_tree().get_first_node_in_group("pickable_items_node")


func spawn_exp_crystal(): # Instantiate drop when eney dies checking chance of drop (to spawn out from enemy, more likely in a specific node in scene)
	var new_exp_crystal = exp_crystal_1.instantiate() as Area2D
	new_exp_crystal.global_position = get_parent().global_position
	pickable_items_node.add_child(new_exp_crystal)

func check_if_exp_crystal_is_dropping():
	if randf_range(0, 1) <= drop_chance:
		spawn_exp_crystal()
