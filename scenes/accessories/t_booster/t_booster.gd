extends Node

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")

var damage_multiplier: float

func _ready():
	call_deferred("update_damage_bonus")

func update_damage_bonus():
	for i in player.weapons_node.get_children().size():
		player.weapons_node.get_children()[i].damage_multiplier += damage_multiplier
		print(player.weapons_node.get_children()[i].damage_multiplier)
		print(player.weapons_node.get_children()[i].name)
	print("Damage bonus updated")
