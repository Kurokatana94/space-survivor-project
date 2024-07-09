extends Node2D

@export var bullet_explosion: PackedScene
var damage_range: Array[float]
var damage_multiplier: float = 1.0
var base_explosion_radius: float

func instantiate_bullet_explosion():
	var new_bullet_explosion = bullet_explosion.instantiate() as Area2D
	new_bullet_explosion.explosion_animation_ended.connect(on_explosion_animation_ended)
	new_bullet_explosion.global_position = get_child(0).global_position
	add_child(new_bullet_explosion)
	new_bullet_explosion.damage_range = damage_range
	new_bullet_explosion.damage_multiplier = damage_multiplier
	new_bullet_explosion.base_explosion_radius = base_explosion_radius


func on_explosion_animation_ended():
	queue_free()

func on_bullet_exploded():
	call_deferred("instantiate_bullet_explosion")
	get_child(0).queue_free()

