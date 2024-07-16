extends Area2D

@export var orb_link_dot: PackedScene
@export var speed: int = 500

var max_distance: int = 350
var damage_range: Array[float]
var damage_multiplier: float
var tags: Array[String]
var critical_chance: float
var critical_damage: float
var dot_tic_cd: float
var dot_name: String
var linked_enemies: Array = []
var travelled_distance: float = 0
# Updated: Store references to instantiated dots
var instantiated_dots: Array = []

func _process(delta):
	var direction: Vector2 = Vector2.RIGHT.rotated(rotation)
	position += direction * delta * speed
	travelled_distance += delta * speed
	if travelled_distance > max_distance:
		orb_deactivation()

func _on_area_exited(area: Area2D):
	if area.name == "HurtboxComponent":
		if area in linked_enemies:
			# Remove the enemy from the linked list
			linked_enemies.erase(linked_enemies.find(area))
			# Additionally, handle the removal of any dots linked to this enemy
			remove_dots_linked_to_enemy(area)

func _on_area_entered(area: Area2D):
	if area.name == "HurtboxComponent":
		# Check if the enemy is already linked
		if area not in linked_enemies:
			print("Linking new enemy and instantiating dot.")
			instantiate_dot_to_target(area)
		else:
			print("Enemy already linked.")

func instantiate_dot_to_target(target: Area2D):
	print("Instantiating dot to target")
	var dot = orb_link_dot.instantiate()
	dot.global_position = target.global_position
	target.add_child(dot)
	# Set properties...
	dot.damage_range = damage_range
	dot.damage_multiplier = damage_multiplier
	# More properties...
	dot.target = target
	var dot_link: Node2D = dot.get_node("LinkToOrb")
	dot_link.orb = self as Node2D
	# Store the dot reference
	instantiated_dots.append(dot)
	# Link dot to enemy
	if target not in linked_enemies:
		linked_enemies.append(target)

func orb_deactivation():
	for dot in instantiated_dots:
		if dot and not dot.is_queued_for_deletion():
			dot.queue_free()
	instantiated_dots.clear()
	queue_free()

func remove_dots_linked_to_enemy(enemy: Area2D):
	for dot in instantiated_dots:
		if dot.target == enemy:
			print("Removing dot linked to enemy")
			dot.queue_free()
			instantiated_dots.erase(dot)
