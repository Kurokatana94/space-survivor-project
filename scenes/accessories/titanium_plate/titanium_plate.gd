extends Node

@onready var player = get_tree().get_first_node_in_group("player")

var armor_buff: float
var speed_debuff: float

func _ready():
    call_deferred("update_player_stats")

func update_player_stats():
    player.health_system_component.base_armor += armor_buff
    player.max_speed -= player.max_speed * speed_debuff