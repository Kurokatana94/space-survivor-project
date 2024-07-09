extends Area2D

signal bullet_hit

@export var speed: int = 500

const MAX_DISTANCE: int = 350

var damage_range: Array[float]
var damage_multiplier: float
var damaged_enemies: Array = []
var travelled_distance: float = 0

func _process(delta):
	var direction: Vector2 = Vector2.RIGHT.rotated(rotation)
	
	position += direction * delta * speed
	
	travelled_distance += delta * speed
	
	if travelled_distance > MAX_DISTANCE:
		queue_free()

func _on_area_entered(hurtbox):
	if hurtbox in damaged_enemies || hurtbox == null:
		return
	else:
		hurtbox.deal_damage_to_target(damage_range, damage_multiplier)
		damaged_enemies.append(hurtbox)
