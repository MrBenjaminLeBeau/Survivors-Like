extends CharacterBody2D

var move_speed = 100
var move_direction = Vector2(0, 0)

var bat_projectile = preload("res://Scenes/bat_projectile.tscn")
var maximum_bats = 8
var bat_number = 0
var projectile_speed = 3
var projectile_radius = 6
var offset = 60 * projectile_radius


func _ready():
	set_spawn_timer()
	spawn_bats()


func _physics_process(delta):
	player_movement()


func player_movement():
	move_direction = Input.get_vector("left", "right", "up", "down").normalized()
	velocity = move_direction * move_speed
	move_and_slide()


func spawn_bats():
	bat_number += 1
	var new_bat = bat_projectile.instantiate()
	new_bat.position = $ShootingPoint.position
	$ShootingPoint.get_parent().add_child(new_bat)
	
	
	
	# OLD WAY TO SPAWN MULTIPLE BATS = NO TIMER
#	for x in range(1, number_of_bats + 1):
#		bat_number = x
#		var new_bat = bat_projectile.instantiate()
#		new_bat.global_position = $ShootingPoint.global_position
#		$ShootingPoint.get_parent().add_child(new_bat)


func _on_timer_timeout():
	if bat_number < maximum_bats:
		spawn_bats()
	else:
		$Timer.stop()


func set_spawn_timer():
	$Timer.wait_time = (2 * PI) / (maximum_bats * projectile_speed) 
	$Timer.start()
