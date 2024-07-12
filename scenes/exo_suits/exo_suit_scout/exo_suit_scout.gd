extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var abilities_manager = get_tree().get_first_node_in_group("abilities_manager")

@export var crystal_charm_manager: AccessoriesData

var exo_suit_name: String = "ExoSuit: Scout"

# Variables to store the modified attributes
var pickup_range_increase: float = 1.5
var max_hp_increase: float = 1.5
var max_speed_increase: float = 1.25

func _ready():
	update_player_attributes()
	instantiate_crystal_charm()

func instantiate_crystal_charm():
	var crystal_charm_instance = crystal_charm_manager.scene.instantiate()
	player.add_child(crystal_charm_instance)
	abilities_manager.equipped_accessories_list.append(crystal_charm_manager)
	abilities_manager.added_accessories += 1

func update_player_attributes():
	player.pickup_area.get_child(0).shape.radius *= pickup_range_increase
	player.health_system_component.max_health = int(player.health_system_component.max_health * max_hp_increase)
	player.health_system_component.current_health = int(player.health_system_component.max_health * max_hp_increase)
	player.max_speed *= max_speed_increase
	