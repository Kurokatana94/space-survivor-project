extends Area2D

@export var plasma_charger_xc_01_bullet: PackedScene

@onready var shooting_cd: Timer = $ShootingCD
@onready var reload_cd: Timer = $ReloadCD

var damage_range: Array[float]
var damage_multiplier: float
var tags: Array[String]
var critical_chance: float
var critical_damage: float
var dot_tic_cd: float
var mag_size: int
var current_mag_size: int
var max_range: float
var reloading: bool = false
var first_shot: bool = true

func _physics_process(delta):
	check_closest_target()
	if first_shot:
		first_shot = false
		current_mag_size = mag_size
		_on_shooting_cd_timeout()

func _on_shooting_cd_timeout():
	if !reloading:
		shoot()

func check_closest_target():
	var enemies_in_range = get_overlapping_areas()
	if enemies_in_range.size() > 0:
		var closest_enemy = enemies_in_range[0]
		var closest_distance = global_position.distance_to(closest_enemy.global_position)
		for enemy in enemies_in_range:
			var distance = global_position.distance_to(enemy.global_position)
			if distance < closest_distance:
				closest_enemy = enemy
				closest_distance = distance
		look_at(closest_enemy.global_position)
	else:
		return

func shoot():
	if current_mag_size > 0:
		var bullet = plasma_charger_xc_01_bullet.instantiate()
		bullet.global_position = $ShootingPoint.global_position
		bullet.global_rotation = $ShootingPoint.global_rotation

		add_child(bullet)

		bullet.max_distance = max_range
		bullet.damage_range = damage_range
		bullet.damage_multiplier = damage_multiplier
		bullet.tags = tags
		bullet.critical_chance = critical_chance
		bullet.critical_damage = critical_damage
		bullet.dot_tic_cd = dot_tic_cd
		current_mag_size -= 1
	else:
		reload()
		return


func reload():
	print("Reloading")
	reloading = true
	shooting_cd.stop()
	reload_cd.start()


func _on_reload_cd_timeout():
	reloading = false
	print("Reloading done")
	shooting_cd.start()
	current_mag_size = mag_size
	reload_cd.stop()

