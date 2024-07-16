extends Node2D

@export var zigzag_amplitude: float = 2
@export var zigzag_frequency: int = 10

@onready var line = $Line2D

var orb: Node2D

func _process(delta):
	update_line()

func update_line():
	var point_a: Vector2 = line.to_local(orb.global_position)
	var point_b: Vector2 = line.to_local(get_parent().get_parent().get_parent().global_position)
	var points = []
	var direction = (point_b - point_a).normalized()
	var normal = Vector2(-direction.y, direction.x)
	var distance = point_a.distance_to(point_b)
	for i in range(zigzag_frequency + 1):
		var t = float(i) / zigzag_frequency
		var pos = point_a.lerp(point_b, t)
		var offset = normal * zigzag_amplitude * ((i % 2) * 2 - 1)
		points.append(pos + offset)
	line.points = points

