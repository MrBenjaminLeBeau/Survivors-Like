extends CharacterBody2D

const XP = preload("res://Scenes/xp.tscn")

var health = 2
var direction
var speed = 50
var attack_strength = 5

@onready var player = get_tree().get_first_node_in_group("player")


func _physics_process(_delta):
	direction = global_position.direction_to(player.global_position).normalized()
	velocity = direction * speed
	move_and_slide()


func _on_hurt_box_hurt(damage):
	health -= damage
	
	if health <= 0:
		var new_xp = XP.instantiate()
		new_xp.global_position = global_position
		get_parent().add_child(new_xp)
		queue_free()
