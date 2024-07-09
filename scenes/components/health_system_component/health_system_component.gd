extends Node
class_name HealthSystemComponent

signal is_dead

@export var base_health: int
@export var base_armor: float
@export var base_shield: int

var armor_cap: float = 0.8
var max_health: int
var current_health: int
var current_shield: int

func _ready():
	print("Health System Component is ready")
	max_health = base_health
	current_health = max_health

func take_damage(damage: int, damage_multiplier: float, critical_chance: float, critical_damage: float, tags: Array[String]):
	current_health -= damage_calculation(damage, damage_multiplier, base_armor, critical_chance, critical_damage, tags)
	check_death()

func check_death():
	if current_health <= 0:
		is_dead.emit()

func damage_calculation(damage_range: int, damage_multiplier: float, armor: float, critical_chance: float, critical_damage: float, tags: Array[String]):
	var damage = damage_range * damage_multiplier
	if critical_chance > 0:
		var critical: float = randf()
		if critical < critical_chance:
			damage *= critical_damage
	var armor_reduction: float = damage * armor
	var final_damage = damage - armor_reduction
	return shield_check(final_damage, tags)

func shield_check(damage: float, tags: Array[String]) -> int:
	var final_damage: int
	if current_shield > 0 && tags != null:
		for tag in tags:
			match tag:
				"projectile":
					damage *= 0.5
				"burning":
					damage *= 0.5
				"plasma":
					damage *= 3
		
		current_shield -= int(damage)

		if current_shield < 0:
			final_damage = abs(current_shield)
			current_shield = 0
		else:
			final_damage = 0
		return final_damage

	else:
		final_damage = int(damage)
		return final_damage
