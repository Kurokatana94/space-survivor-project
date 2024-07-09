extends Node

const SPAWN_RADIUS = 570

#To do: a lot of stuff in here
#To add: all different enemies and when/how often they spawn/in which combination/other stuff i don't know at the moment, plz halp
@export var enemy_1: PackedScene

@onready var entities_node = get_tree().get_first_node_in_group("entities_node")
#To add: a lot of @export to instanciate the various enemies

func spawn_enemies():
	var player = get_selected_playable_chara() as Node2D
	if player == null:
		return
	
	var new_enemy = enemy_1.instantiate() as Node2D
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position = player.global_position + (random_direction * SPAWN_RADIUS)
	
	entities_node.add_child(new_enemy)
	
	new_enemy.global_position = spawn_position


func _on_timer_timeout():
	spawn_enemies()

func get_selected_playable_chara():
	var playable_charas_list = get_tree().get_nodes_in_group("player")
	if playable_charas_list != null:
		for player in playable_charas_list.size():
			if playable_charas_list[player].name == global_data.selected_character:
				return playable_charas_list[player]
	else:
		return
