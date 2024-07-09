extends Node

signal leveled_up

var player_level: int = 1
var current_gained_experience: int = 0
var experience_needed: int = 5
var experience_modifier: int = 5
var extra_exp: int = 0

func level_up(): # when levels up will higher needed experience and give power ups/new weapons (probably)
	player_level += 1
	current_gained_experience = 0
	experience_needed = experience_needed + experience_modifier
	print("leveled to lv" + str(player_level))
	leveled_up.emit()

func add_experience(exp_amount):
	current_gained_experience += exp_amount + extra_exp
	if current_gained_experience >= experience_needed:
		level_up()
