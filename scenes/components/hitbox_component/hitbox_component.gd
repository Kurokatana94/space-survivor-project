extends Area2D
class_name HitboxComponent

@export var damage: float
@export var damage_multiplier: int = 1
@export var damage_cd: float = 1.0
@onready var damage_cd_timer: Timer = $DamageCDTimer

var tags: Array[String] = []
var damage_range: Array[float] = [0, 0]
var target: Area2D

func _ready():
	damage_range[0] = damage
	damage_range[1] = damage

# Called when an area enters the HitboxComponent's area
func _on_area_entered(area: Area2D):
	if area == null || area.name != "HurtboxComponent":
		return
	if damage_cd_timer.is_stopped():
		target = area
		damage_cd_timer.start(damage_cd)
		deal_damage()

# Called when the damage cooldown timer times out
func _on_damage_cd_timer_timeout():
	deal_damage()

# Called when an area exits the HitboxComponent's area
func _on_area_exited(area: Area2D):
	damage_cd_timer.stop()
	target = null

# Function to deal damage to the target
func deal_damage():
	if target == null:
		return
	target.deal_damage_to_target(damage_range, damage_multiplier, 0.0, 0.0, tags)

