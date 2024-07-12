extends Node

@export var t_booster_lq: PackedScene
@export var t_booster_nm: PackedScene
@export var t_booster_hq: PackedScene

const MAX_LEVEL = 2
var level: int = 0

func _ready():
	match level:
		0:
			instantiate_t_booster(t_booster_lq, .1)
		1:
			instantiate_t_booster(t_booster_nm, .25)
		2:
			instantiate_t_booster(t_booster_hq, .5)

func instantiate_t_booster(t_booster: PackedScene, damage_multiplier: float):
	var new_t_booster = t_booster.instantiate()
	add_child(new_t_booster)

	new_t_booster.damage_multiplier = damage_multiplier
