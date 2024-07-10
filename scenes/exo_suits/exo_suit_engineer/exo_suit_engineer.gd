extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")

@export var OverclockChip: PackedScene

var exo_suit_name: String = "ExoSuit: Scout"

var turret_damage_increase: float = 1.25
var turret_cd_decrease: float = 0.8
var armor_increase: float = 1.10
var movement_speed_decrease: float = 0.10
var damage_decrease: float = 0.10

