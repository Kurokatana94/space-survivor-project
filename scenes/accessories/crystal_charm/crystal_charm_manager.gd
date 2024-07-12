extends Node

signal update_experience_bonuses

@export var crystal_charm_lq: PackedScene
@export var crystal_charm_nm: PackedScene
@export var crystal_charm_hq: PackedScene

const MAX_LEVEL = 2
var level: int = 0

func _ready():
	match level:
		0:
			instantiate_crystal_charm(crystal_charm_lq, .5)
		1:
			instantiate_crystal_charm(crystal_charm_nm, 1)
		2:
			instantiate_crystal_charm(crystal_charm_hq, 2)

func instantiate_crystal_charm(crystal_charm: PackedScene, exp_multiplier: float):
	var new_crystal_charm = crystal_charm.instantiate()
	add_child(new_crystal_charm)

	new_crystal_charm.exp_multiplier = exp_multiplier

	update_experience_bonuses.emit()
