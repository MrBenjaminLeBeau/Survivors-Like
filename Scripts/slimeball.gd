extends Area2D

var projectile_number
var direction = Vector2(1, 1)
var shoot_distance = 100
var damage = 1
var speed = 200
var number_of_bounces = 0
var travel_distance = 0


func _ready():
	projectile_number = get_parent().projectile_number
	direction = set_projectile_direction(projectile_number)
	shoot_distance = get_parent().shoot_distance
	damage = get_parent().damage
	speed = get_parent().projectile_speed
	number_of_bounces = get_parent().number_of_bounces


func _physics_process(delta):
	position += direction * speed * delta
	travel_distance += speed * delta
	if travel_distance > shoot_distance:
		queue_free()


func set_projectile_direction(projectile):
	if projectile == 1:
		return Vector2(get_parent().shoot_direction.x, 0)
	elif projectile == 2:
		return Vector2(get_parent().shoot_direction.x * -1, 0)
	elif projectile == 3:
		return Vector2(0, get_parent().shoot_direction.y)
	elif projectile == 4:
		return Vector2(0, get_parent().shoot_direction.y * -1)


func enemy_hit(charge = 1):
	if number_of_bounces > 0:
		if direction.x != 0:
			direction.y += randf_range(-0.9, 0.9)
		if direction.y != 0:
			direction.x += randf_range(-0.9, 0.9)
		direction *= -1
		direction = direction.normalized()
		number_of_bounces -= 1
	else:
		queue_free()
