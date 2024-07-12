extends Node

signal skill_selected
signal accessories_selected

@export var abilities_menu: PackedScene
@export var skill_list: Array[AbilitiesData]
@export var accessories_list: Array[AbilitiesData]
@export var substitute_list: Array[AbilitiesData]
@export var power_up_list: Array[AbilitiesData]
@export var abilities_node: Node2D

@onready var experience_manager = get_tree().get_first_node_in_group("experience_manager")
@onready var ui = get_tree().get_first_node_in_group("ui")
@onready var pickable_items_node = get_tree().get_first_node_in_group("pickable_items")
@onready var player = get_tree().get_first_node_in_group("player")

var max_equippable_skills = 5
var max_equippable_accessories = 5
var equipped_skill_list: Array[AbilitiesData] = []
var equipped_accessories_list: Array[AbilitiesData] = []
var chosen_skill_substitute_list: Array[AbilitiesData] = []
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

func choose_random_skill() -> AbilitiesData:
	var chosen_skill: AbilitiesData
	var skill_already_equipped = false
	if equipped_skill_list.size() >= max_equippable_skills -1:
		return choose_random_skill_substitute()
	while true:
		chosen_skill = skill_list[randi() % skill_list.size()]
		skill_already_equipped = equipped_skill_list.has(chosen_skill)

		if skill_already_equipped && chosen_skill.level >= chosen_skill.max_level:
			continue
		else:
			break
	if !skill_already_equipped:
		equipped_skill_list.append(chosen_skill)
	
	return chosen_skill

func choose_random_skill_substitute() -> AbilitiesData:
	chosen_skill_substitute_list.clear()
	var chosen_skill_substitute: AbilitiesData
	while true:
		chosen_skill_substitute = substitute_list[randi() % substitute_list.size()]
		if !chosen_skill_substitute_list.has(chosen_skill_substitute):
			continue
		else:
			chosen_skill_substitute_list.append(chosen_skill_substitute)
			break
	return chosen_skill_substitute

func choose_random_accessory() -> AbilitiesData:
	var chosen_accessory: AbilitiesData
	var accessory_already_equipped = false
	while true:
		chosen_accessory = accessories_list[randi() % accessories_list.size()]
		accessory_already_equipped = equipped_accessories_list.has(chosen_accessory)

		if accessory_already_equipped:
			continue
		else:
			equipped_accessories_list.append(chosen_accessory) #actually it shouldn't be here, but in the add_accessories function. First it must send the data to the button, then if selected, it should be added to the equipped list
			break
	return chosen_accessory

func choose_random_power_up() -> AbilitiesData:
	var chosen_power_up: AbilitiesData
	while true:
		chosen_power_up = power_up_list[randi() % power_up_list.size()]
		if chosen_power_up.level >= chosen_power_up.max_level:
			continue
		else:
			break
	return chosen_power_up

func instatiate_skill(skill: AbilitiesData):
	var skill_instance = skill.scene.instantiate()
	player.add_child(skill_instance)
	skill_instance.global_position = player.global_position

func instantiate_power_up(spawn_position: Vector2):
	var power_up = choose_random_power_up().scene.instantiate()
	pickable_items_node.add_child(power_up)
	power_up.global_position = spawn_position