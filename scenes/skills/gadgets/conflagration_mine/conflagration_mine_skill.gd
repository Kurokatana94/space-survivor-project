extends Node2D

@export var conflagration_mine: PackedScene

@onready var deployment_cd: Timer = $DeploymentCD

var damage_range: Array[float]
var damage_multiplier: float
var base_explosion_radius: float
var mines_quantity: int
var spawn_radius: float = 150  # radius around the player where the mines will spawn
var first_deployment: bool = true
var tags: Array[String]

func _process(delta):
    if first_deployment:
        instantiate_mines()
        first_deployment = false

func instantiate_mines():
    for i in mines_quantity:
        var new_mine = conflagration_mine.instantiate()
        new_mine.global_position = get_random_location_around_player()
        add_child(new_mine)
        new_mine.damage_range = damage_range
        new_mine.damage_multiplier = damage_multiplier
        new_mine.base_explosion_radius = base_explosion_radius
        new_mine.tags = tags

func get_random_location_around_player():
    var random_x = randf_range(global_position.x - spawn_radius, global_position.x + spawn_radius)
    var random_y = randf_range(global_position.y - spawn_radius, global_position.y + spawn_radius)
    return Vector2(random_x, random_y)

func _on_deployment_cd_timeout():
    instantiate_mines()
