extends Area2D
signal explosion_animation_ended

var damage_range: Array[float]
var damage_multiplier: float
var tags: Array[String]
var base_explosion_radius: float
var has_damage_been_applied: bool = false

func _process(delta):
	update_explosion_area()
	if !has_damage_been_applied:
		apply_damage(damage_range, damage_multiplier)
		$AnimatedSprite2D.play("default")
	else:
		return

func apply_damage(applied_damage_range: Array[float], multiplier: float):
	var targets_in_range = get_overlapping_areas()
	if targets_in_range == null or targets_in_range.size() == 0:
		return
	else:
		for target in targets_in_range.size():
			if targets_in_range[target] != null or target >= targets_in_range.size():
				var current_target = targets_in_range[target]
				print(damage_multiplier)
				current_target.deal_damage_to_target(applied_damage_range, multiplier, 0.0, 0.0, tags)
				if target == targets_in_range.size() -1:
					has_damage_been_applied = true
			else:
				has_damage_been_applied = true
				if !has_damage_been_applied:
					return

func _on_animated_sprite_2d_animation_finished():
	explosion_animation_ended.emit()

func update_explosion_area():
	$CollisionShape2D.shape.radius = base_explosion_radius
