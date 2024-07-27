extends Node2D

signal grenade_exploded

@export var speed: int = 300
@export var arc_height: float = 30

@onready var explosion_delay: Timer = $ExplosionDelay

var distance_to_target: float
var travelled_distance: float = 0
var start_position: Vector2
var end_position: Vector2
var first_frame: bool = true

func _physics_process(delta):
	if first_frame:
		start_position = global_position
		first_frame = false
		end_position = get_end_position(start_position, rotation, distance_to_target)
	
	var direction = Vector2.RIGHT.rotated(rotation)
	travelled_distance += delta * speed
	
	if travelled_distance >= distance_to_target && explosion_delay.is_stopped():
		speed = 0
		explosion_delay.start()
	
	# Calculate the normalized progress ratio
	var progress_ratio = travelled_distance / distance_to_target
	
	# Linear interpolation between start and end position
	var linear_position = start_position.lerp(end_position, progress_ratio)
	
	# Calculate the vertical offset for the arc
	var vertical_offset = 4 * arc_height * progress_ratio * (progress_ratio - 1)
	
	# Set the new position with the vertical offset
	position = Vector2(linear_position.x, linear_position.y + vertical_offset)

func _on_explosion_delay_timeout():
	grenade_exploded.emit()

func get_end_position(initial_position: Vector2, rotation: float, distance: float) -> Vector2:
	print("Initial Position: ", initial_position)
	print("Rotation (radians): ", rotation)
	print("Distance: ", distance)
	
	var direction = Vector2(cos(rotation), sin(rotation))
	print("Direction: ", direction)
	
	var offset = direction * distance
	print("Offset: ", offset)
	print("End Position: ", initial_position + offset)
	
	return initial_position + offset
