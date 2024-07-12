extends CharacterBody2D
const MAX_SPEED: int = 50
@onready var playable_charas_list = get_tree().get_nodes_in_group("player")
@onready var exp_drop_manager = $ExpDropManager
var current_player

func _ready():
	current_player = get_selected_playable_chara()

func _process(delta):
	var direction = get_direction_to_player()
	if direction == null:
		return
	velocity = direction * MAX_SPEED
	move_and_slide()

func get_direction_to_player():
	if current_player == null:
		return
	return (current_player.global_position - global_position).normalized()

func _on_health_system_component_is_dead():
	death()

func death(): #to add death animation here like in all playable charas
	exp_drop_manager.check_if_exp_crystal_is_dropping()
	queue_free()

func get_selected_playable_chara():
	if playable_charas_list != null:
		for player in playable_charas_list.size():
			if playable_charas_list[player].name == global_data.selected_character:
				return playable_charas_list[player]
	else:
		return
