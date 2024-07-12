extends Node2D

@export var sparka_12_shotgun: PackedScene
@export var tags: Array[String]

var damage_range: Array[float] = [15.0, 18.0] #damage range for base level weapon
var damage_multiplier: float = 1.0
var critical_chance: float = 0.0
var critical_damage: float = 2.0
var pallets_amount: int = 8
var reload_speed: float = 5.5
var base_range: float = 120
var type: String = "skill"
var ability_name: String = "SPARKA 12"
var description: String = "A shotgun that shoots multiple bullets in a cone"
const MAX_LEVEL: int = 5
var current_level: int = 0

func _ready():
    instantiate_gun()

func level_up():
    if current_level < MAX_LEVEL:
        current_level += 1
    instantiate_gun()

func instantiate_gun():
    var new_gun = sparka_12_shotgun.instantiate()
    new_gun.global_position = get_parent().global_position
    add_child(new_gun)
    new_gun.damage_range = damage_range
    new_gun.max_range = base_range
    new_gun.tags = tags

    match current_level:
        0:
            new_gun.damage_multiplier = damage_multiplier
            new_gun.pallets_amount = pallets_amount
            new_gun.reload_speed = reload_speed
            new_gun.critical_chance = critical_chance
            new_gun.critical_damage = critical_damage
        1:
            new_gun.damage_multiplier = damage_multiplier
            new_gun.pallets_amount = pallets_amount
            new_gun.reload_speed = reload_speed - 0.5
            new_gun.shooting_cd.wait_time -= 0.2
            new_gun.critical_chance = critical_chance
            new_gun.critical_damage = critical_damage
        2:
            new_gun.damage_multiplier = damage_multiplier + .5
            new_gun.pallets_amount = pallets_amount
            new_gun.reload_speed = reload_speed - 0.5
            new_gun.shooting_cd.wait_time -= 0.2
            new_gun.critical_chance = critical_chance
            new_gun.critical_damage = critical_damage

            if new_gun.shooting_cd.is_stopped():
                new_gun.shooting_cd.start()
            else:
                new_gun.shooting_cd.stop()
                new_gun.shooting_cd.start()
        3:
            new_gun.damage_multiplier = damage_multiplier + 5
            new_gun.pallets_amount = pallets_amount + 2
            new_gun.reload_speed = reload_speed - 0.5
            new_gun.shooting_cd.wait_time -= 0.2
            new_gun.critical_chance = critical_chance
            new_gun.critical_damage = critical_damage

            if new_gun.shooting_cd.is_stopped():
                new_gun.shooting_cd.start()
            else:
                new_gun.shooting_cd.stop()
                new_gun.shooting_cd.start()
        4:
            new_gun.damage_multiplier = damage_multiplier + 1.5
            new_gun.pallets_amount = pallets_amount + 2
            new_gun.reload_speed = reload_speed - 0.5
            new_gun.shooting_cd.wait_time -= 0.2
            new_gun.critical_chance = critical_chance
            new_gun.critical_damage = critical_damage

            if new_gun.shooting_cd.is_stopped():
                new_gun.shooting_cd.start()
            else:
                new_gun.shooting_cd.stop()
                new_gun.shooting_cd.start()
        5:
            new_gun.damage_multiplier = damage_multiplier + 1.5
            new_gun.pallets_amount = pallets_amount + 2
            new_gun.reload_speed = reload_speed - 0.5
            new_gun.shooting_cd.wait_time -= 0.2
            new_gun.max_range = 500
            new_gun.critical_chance = critical_chance
            new_gun.critical_damage = critical_damage

            if new_gun.shooting_cd.is_stopped():
                new_gun.shooting_cd.start()
            else:
                new_gun.shooting_cd.stop()
                new_gun.shooting_cd.start()