extends CharacterBody2D

@onready var health_system_component: HealthSystemComponent = $HealthSystemComponent
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready var pickup_area: Area2D = $PickUpArea

var direction: Vector2
var max_speed: int = 150

const ACCELERATION_SMOOTHING = 25

func _ready():
	print("Playable Character 1 is ready")

func _process(delta):
	var movement_vector = get_movement_vector()
	direction = movement_vector.normalized()
	var target_velocity = direction * max_speed
	
	velocity = velocity.lerp(target_velocity, 1 - exp(-delta * ACCELERATION_SMOOTHING))
	move_and_slide()

func get_movement_vector():
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(x_movement,y_movement)


func _on_health_system_component_is_dead():
	player_death()


func player_death():
	print("Player is dead")
	return
