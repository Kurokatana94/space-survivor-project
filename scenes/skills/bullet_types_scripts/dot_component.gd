extends Node2D

var target
var damage_range: Array[float]
var damage_multiplier: float
var tags: Array[String]
var critical_chance: float
var critical_damage: float
var dot_tic_cd: float
var first_tic: bool = true

func _physics_process(delta):
	if first_tic:
		first_tic = false
		_on_dot_tic_cd_timeout()


func _on_dot_tic_cd_timeout():
	if target:
		target.deal_damage_to_target(damage_range, damage_multiplier, critical_chance, critical_damage, tags)
	else:
		return
