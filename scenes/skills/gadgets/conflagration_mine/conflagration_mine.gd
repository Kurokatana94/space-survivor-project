extends Node2D

@export var mine_explosion: PackedScene

var damage_range: Array[float]
var damage_multiplier: float
var tags: Array[String]
var base_explosion_radius: float

func instantiate_mine_explosion():
	var new_mine_explosion = mine_explosion.instantiate() as Area2D
	new_mine_explosion.explosion_animation_ended.connect(on_explosion_animation_ended)
	new_mine_explosion.global_position = global_position
	add_child(new_mine_explosion)
	new_mine_explosion.damage_range = damage_range
	new_mine_explosion.damage_multiplier = damage_multiplier
	new_mine_explosion.base_explosion_radius = base_explosion_radius
	new_mine_explosion.tags = tags

func on_explosion_animation_ended():
	queue_free()

func _on_trigger_area_entered(area:Area2D):
	if area.name == "HurtboxComponent":
		call_deferred("instantiate_mine_explosion")
		get_child(0).queue_free()

func _on_deployment_duration_timeout():
	call_deferred("instantiate_mine_explosion")
	get_child(0).queue_free()
