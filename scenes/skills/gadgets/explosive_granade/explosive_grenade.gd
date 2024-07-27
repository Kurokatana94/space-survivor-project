extends Node2D

@export var grenade_explosion: PackedScene
var damage_range: Array[float]
var damage_multiplier: float = 1.0
var tags: Array[String]
var base_explosion_radius: float

func instantiate_grenade_explosion():
	var new_grenade_explosion = grenade_explosion.instantiate() as Area2D
	new_grenade_explosion.explosion_animation_ended.connect(_on_explosion_animation_ended)
	new_grenade_explosion.global_position = get_child(0).global_position
	add_child(new_grenade_explosion)
	new_grenade_explosion.damage_range = damage_range
	new_grenade_explosion.damage_multiplier = damage_multiplier
	new_grenade_explosion.base_explosion_radius = base_explosion_radius
	new_grenade_explosion.tags = tags


func _on_explosion_animation_ended():
	queue_free()

func on_grenade_exploded():
	print("Grenade exploded")
	instantiate_grenade_explosion()
	get_child(0).queue_free()
