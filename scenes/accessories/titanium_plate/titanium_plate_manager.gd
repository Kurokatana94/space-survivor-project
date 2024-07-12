extends Node

@export var titanium_plate_lq: PackedScene
@export var titanium_plate_nm: PackedScene
@export var titanium_plate_hq: PackedScene

const MAX_LEVEL = 2
var level: int = 0

func _ready():
    match level:
        0:
            instantiate_titanium_plate(titanium_plate_lq, .1, .1)
        1:
            instantiate_titanium_plate(titanium_plate_nm, .25, .05)
        2:
            instantiate_titanium_plate(titanium_plate_hq, .4, 0)

func instantiate_titanium_plate(titanium_plate: PackedScene, armor_buff: float, speed_debuff: float):
    var new_titanium_plate = titanium_plate.instantiate()
    add_child(new_titanium_plate)

    new_titanium_plate.armor_buff = armor_buff
    new_titanium_plate.speed_debuff = speed_debuff
