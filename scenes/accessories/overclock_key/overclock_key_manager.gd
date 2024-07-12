extends Node

@export var overclock_key_lq: PackedScene
@export var overclock_key_nm: PackedScene
@export var overclock_key_hq: PackedScene

const MAX_LEVEL = 2
var level: int = 0

func _ready():
    match level:
        0:
            instantiate_overclock_key(overclock_key_lq, .05, .05)
        1:
            instantiate_overclock_key(overclock_key_nm, .15, .1)
        2:
            instantiate_overclock_key(overclock_key_hq, .25, .2)

func instantiate_overclock_key(overclock_key: PackedScene, damage_multiplier: float, deployment_cd: float):
    var new_overclock_key = overclock_key.instantiate()
    add_child(new_overclock_key)

    new_overclock_key.damage_multiplier = damage_multiplier
    new_overclock_key.deployment_cd = deployment_cd
