extends Node

@onready var experience_manager: Node = get_tree().get_first_node_in_group("experience_manager")

var exp_bonus: float
var exp_multiplier: float

func _ready():
    get_parent().update_experience_bonuses.connect(on_update_experience_bonus)

func on_update_experience_bonus():
    experience_manager.exp_bonus += exp_bonus
    experience_manager.exp_multiplier += exp_multiplier 
    print("Experience bonus updated")