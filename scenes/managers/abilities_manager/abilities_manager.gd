extends Node

signal skill_selected
signal accessories_selected

@export var abilities_menu: PackedScene
@export var main_weapons_list: Array[PackedScene]
@export var skill_list: Array[AbilitiesData]
@export var accessories_list: Array[PackedScene]
@export var abilities_node: Node2D
@onready var experience_manager = get_tree().get_first_node_in_group("experience_manager")
@onready var ui = get_tree().get_first_node_in_group("ui")

var max_equippable_skills = 4
var max_equippable_accessories = 4
var equipped_skill_list: Array
var equipped_accessories_list: Array
var added_skills = 0
var added_accessories = 0

func _ready():
	experience_manager.leveled_up.connect(on_leveled_up)
	equipped_skill_list.resize(max_equippable_skills)
	equipped_accessories_list.resize(max_equippable_accessories)

func on_leveled_up():
	get_tree().paused = true
	var new_abilities_menu = abilities_menu.instantiate()
	
	ui.add_child(new_abilities_menu)

func check_skills():
	if added_skills < max_equippable_skills:
		add_skill()
		added_skills += 1
	


func check_accessories():
	if added_accessories < max_equippable_accessories:
		add_accessories()
		added_accessories += 1


func add_skill():
	pass


func add_accessories():
	pass


func get_random_abilities_to_choose():
	var selected_abilities: Array
	for i in 2:
		var random_type = randi_range(1,2) # Random type goes 1: for skills and 2: for accessories
		if random_type == 1:
			var random_skill = randi_range(1,skill_list.size())
			if selected_abilities.size() != null:
				if random_skill == selected_abilities[0]:
					if random_skill == 1:
						random_skill = skill_list.size()
						break
			selected_abilities.append(random_skill)
		else:
			var random_accessories = randi_range(1,accessories_list.size())
			if selected_abilities.size() != null:
				if random_accessories == selected_abilities[0]:
					if random_accessories == 1:
						random_accessories = skill_list.size()
						break
			selected_abilities.append(random_accessories)
			skill_selected.emit()
	return selected_abilities
	#To check the possibility you have that skill and want to power that one up

