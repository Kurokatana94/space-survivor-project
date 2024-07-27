extends Node2D

@export var explosive_granade_skill: PackedScene
@export var tags: Array[String]

var damage_range: Array[float] = [120.0, 120.0] #damage range for base level weapon
var damage_multiplier: float = 1.0
var base_explosion_radius: float = 20.0
var grenades_quantity: int = 1
var type = "skill"
var ability_name = "Explosive Granade"
var description = "A granade that explodes after a little delay dealing damage to enemies in the area"
const MAX_LEVEL = 5
var current_level = 0

func _ready():
    call_deferred("instantiate_explosive_granade")

func instantiate_explosive_granade():
    var new_explosive_granade = explosive_granade_skill.instantiate()
    new_explosive_granade.global_position = global_position
    add_child(new_explosive_granade)
    new_explosive_granade.damage_range = damage_range
    new_explosive_granade.tags = tags
    new_explosive_granade.grenades_quantity = grenades_quantity
    new_explosive_granade.base_explosion_radius = base_explosion_radius
    match current_level:
        0:
            new_explosive_granade.damage_multiplier = damage_multiplier
        1:
            new_explosive_granade.damage_multiplier = damage_multiplier
        2:
            new_explosive_granade.damage_multiplier = damage_multiplier
        3:
            new_explosive_granade.damage_multiplier += damage_multiplier * .5
        4:
            new_explosive_granade.damage_multiplier += damage_multiplier * .5
        5:
            new_explosive_granade.damage_multiplier += damage_multiplier

