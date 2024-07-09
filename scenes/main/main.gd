extends Node

@export var player_scene: PackedScene
@export var exo_suit_list: Array[Dictionary]
@export var weapon_list: Array[Dictionary]

func _ready():
	instantiate_player()
	var player = get_tree().get_first_node_in_group("player")
	instantiate_weapons(player)
	instantiate_exo_suit(player)

func instantiate_player():
	var player = player_scene.instantiate()
	player.global_position = Vector2(0,0)
	$%Entities.add_child(player)

func instantiate_exo_suit(player: CharacterBody2D):
	if global_data.selected_exo_suit == "":
		return
	for i in exo_suit_list.size():
		if exo_suit_list[i]["exo_suit_name"] == global_data.selected_exo_suit:
			var exo_suit = exo_suit_list[i]["scene"].instantiate()
			exo_suit.global_position = Vector2(0,0)
			player.add_child(exo_suit)

func instantiate_weapons(player: CharacterBody2D):
	if global_data.selected_weapon == "":
		return
	for i in weapon_list.size():
		if weapon_list[i]["weapon_name"] == global_data.selected_weapon:
			var weapon = weapon_list[i]["scene"].instantiate()
			player.add_child(weapon)