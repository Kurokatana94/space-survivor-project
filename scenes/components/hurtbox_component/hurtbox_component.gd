extends Area2D
class_name HurtboxComponent

@export var health_system_component: HealthSystemComponent

func deal_damage_to_target(damage_range: Array[float], damage_multiplier: float, critical_chance: float, critical_damage: float, tags: Array[String]):
	var damage = float(int(randf_range(damage_range[0], damage_range[1])))
	health_system_component.take_damage(damage, damage_multiplier, critical_chance, critical_damage, tags)



