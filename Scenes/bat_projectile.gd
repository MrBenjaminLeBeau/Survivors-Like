extends Area2D

var time = 0.0
var speed = 0
var radius = 2
var rotation_angle = Vector2(0, 0)
var damage = 1
var offset = 0


func _ready():
	offset = get_parent().offset
	radius = get_parent().projectile_radius
	speed = get_parent().projectile_speed
	set_bat_position()


func _physics_process(delta):
	time += delta
	var angle = speed * time
	var rotation_angle = Vector2(cos(angle), sin(angle))
	position += rotation_angle * speed * radius


func set_bat_position():
	position = Vector2(0, -offset)
	# OLD WAY
#	if get_parent().bat_number == 1:
#		position = Vector2(0, -radius)
#	elif get_parent().bat_number == 2:
#		position = Vector2(0, radius)
#	elif get_parent().bat_number == 3:
#		position = Vector2(radius, 0)
#	elif get_parent().bat_number == 4:
#		position = Vector2(-radius, 0)


func enemy_hit(charge = 1):
	pass
