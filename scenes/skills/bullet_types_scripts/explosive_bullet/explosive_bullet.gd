extends Area2D

signal bullet_exploded

@export var speed: int = 500

const MAX_DISTANCE = 200

var travelled_distance: float = 0

func _process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * delta * speed
	
	travelled_distance += delta * speed
	
	if travelled_distance > MAX_DISTANCE:
		bullet_exploded.emit()

func _on_area_entered(body: Area2D):
	bullet_exploded.emit()
