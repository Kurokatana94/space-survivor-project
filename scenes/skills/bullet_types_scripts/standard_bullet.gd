extends Area2D

@export var speed: int = 500
@export var max_distance: int = 350

var damage_range: Array[float]
var damage_multiplier: float
var tags: Array[String]
var critical_chance: float
var critical_damage: float
var travelled_distance: float = 0

func _process(delta):
	var direction: Vector2 = Vector2.RIGHT.rotated(rotation)
	
	position += direction * delta * speed
	
	travelled_distance += delta * speed
	
	if travelled_distance > max_distance:
		queue_free()

func _on_area_entered(hurtbox):
	if hurtbox == null:
		return
	else:
		hurtbox.deal_damage_to_target(damage_range, damage_multiplier, critical_chance, critical_damage, tags)
		queue_free()
