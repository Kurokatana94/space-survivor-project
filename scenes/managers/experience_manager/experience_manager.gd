extends Node

signal leveled_up

var player_level: int = 1
var current_gained_experience: float = 0
var experience_needed: float = 5
var experience_modifier: float = 5
var exp_bonus: float = 0
var exp_multiplier: float = 1.0

func level_up(): # when levels up will higher needed experience and give power ups/new weapons (probably)
	player_level += 1
	if current_gained_experience > experience_needed:
		current_gained_experience = current_gained_experience - experience_needed
	else:
		current_gained_experience = 0
	experience_needed = experience_needed + experience_modifier
	print("leveled to lv" + str(player_level))
	leveled_up.emit()

func add_experience(exp_amount):
	current_gained_experience += (exp_amount + exp_bonus) * exp_multiplier
	print("current exp: " + str(current_gained_experience))
	if current_gained_experience >= experience_needed:
		level_up()
