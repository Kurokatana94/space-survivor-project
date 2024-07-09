extends Area2D

@onready var experience_manager = get_tree().get_first_node_in_group("experience_manager")

@export var exp_amount = 1

func _on_area_entered(area):
	experience_manager.add_experience(exp_amount)
	queue_free()
