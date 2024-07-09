extends MarginContainer

@export var buttons: Array[Button]
@onready var abilities_manager = get_tree().get_first_node_in_group("abilities_manager")

func _ready():
	buttons[0].text = "Skill 1"


func _on_button_pressed():
	get_tree().paused = false
	queue_free()
