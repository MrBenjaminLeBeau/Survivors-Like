extends CharacterBody2D

signal health_depleted

# Arrow Attack Variables
var arrow = preload("res://Scenes/arrow.tscn")
@onready var arrow_timer: Timer = get_node("%ArrowTimer")
@onready var arrow_attack_timer: Timer = get_node("%ArrowAttackTimer")
var arrow_ammo = 0
var arrow_base_ammo = 1
var arrow_attack_speed = 1.5
var arrow_level = 1
var enemy_close = []
# End Arrow Attack Variables

var current_xp = 0
var xp_level = 1
var collected_xp = 0

var max_health = 100.0
var current_health = max_health

var move_speed = 100
var move_direction = Vector2(0, 0)

# Slimeball Attacks
var slimeball = preload("res://Scenes/slimeball.tscn")
var shoot_direction = Vector2(1, 1)
var number_of_projectiles = 1
var shoot_distance = 100
var damage = 1
var projectile_speed = 200
var projectile_number = 0
@onready var slime_shoot_timer: Timer = get_node("ShootingTimer")
var number_of_bounces = 0


# Upgrades
var collected_upgrades = []
var new_upgrades = []

# GUI Variables
@onready var xp_bar = get_tree().get_first_node_in_group("xp_bar")
@onready var level_label = get_tree().get_first_node_in_group("level_label")
@onready var level_panel = get_tree().get_first_node_in_group("level_panel")
@onready var upgrade_options = get_tree().get_first_node_in_group("upgrade_options")
@onready var item_options = preload("res://Scenes/item_option.tscn")

func _ready():
	# arrow_attack()
	set_xp_bar(current_xp, calculate_xp_cap())


func _physics_process(delta):
	player_movement()
	set_shooting_direction()


func player_movement():
	move_direction = Input.get_vector("left", "right", "up", "down").normalized()
	velocity = move_direction * move_speed
	move_and_slide()


func set_shooting_direction():
	if move_direction.x < 0:
		shoot_direction.x = -1
	elif move_direction.x > 0:
		shoot_direction.x = 1

	if move_direction.y < 0:
		shoot_direction.y = -1
	elif move_direction.y > 0:
		shoot_direction.y = 1


func _on_shooting_timer_timeout():
	shoot()


func shoot():
	for projectile in range(1, number_of_projectiles + 1):
		projectile_number = projectile
		var new_bullet = slimeball.instantiate()
		new_bullet.global_position = $ShootingPoint.global_position
		$ShootingPoint.get_parent().add_child(new_bullet)

	projectile_number = 0


func _on_hurt_box_hurt(damage):
	current_health -= damage
	$HealthBar.value = current_health
	
	if current_health <= 0.0:
		health_depleted.emit()


func arrow_attack():
	if arrow_level > 0:
		arrow_timer.wait_time = arrow_attack_speed
		if arrow_timer.is_stopped():
			arrow_timer.start()


func _on_arrow_timer_timeout():
	arrow_ammo += arrow_base_ammo
	arrow_attack_timer.start()


func _on_arrow_attack_timer_timeout():
	if arrow_ammo > 0:
		var arrow_attack = arrow.instantiate()
		arrow_attack.position = position
		arrow_attack.target = get_random_target()
		arrow_attack.level = arrow_level
		add_child(arrow_attack)
		arrow_ammo -= 1
		if arrow_ammo > 0:
			arrow_attack_timer.start()
		else:
			arrow_attack_timer.stop()


func get_random_target():
	if enemy_close.size() > 0:
		return enemy_close.pick_random().global_position
	else:
		return Vector2.UP


func _on_enemy_detection_area_body_entered(body):
	if not enemy_close.has(body):
		enemy_close.append(body)


func _on_enemy_detection_area_body_exited(body):
	if enemy_close.has(body):
		enemy_close.erase(body)


func _on_grab_area_area_entered(area):
	if area.is_in_group("loot"):
		area.target = self


func _on_collect_area_area_entered(area):
	if area.is_in_group("loot"):
		var xp = area.collect()
		calculate_xp(xp)


func calculate_xp(xp):
	var xp_required = calculate_xp_cap()
	collected_xp += xp
	if current_xp + collected_xp >= xp_required:
		collected_xp -= xp_required - current_xp
		xp_level += 1
		level_label.text = str("Level: ", xp_level)
		current_xp = 0
		xp_required = calculate_xp_cap()
		level_up()

	else:
		current_xp += collected_xp
		collected_xp = 0
	
	set_xp_bar(current_xp, xp_required)


func calculate_xp_cap():
	var xp_cap = xp_level
	
	if xp_level < 20:
		xp_cap = xp_level * 5
	elif xp_level < 40:
		xp_cap = 95 + (xp_level - 19) * 8
	else:
		xp_cap = 255 + (xp_level - 39) * 12
	
	return xp_cap


func set_xp_bar(set_value = 1, set_max_value = 100):
	xp_bar.value = set_value
	xp_bar.max_value = set_max_value


func level_up():
	level_panel.visible = true
	var options = 0
	var max_options = 7
	while options < max_options:
		var option_choice = item_options.instantiate()
		option_choice.item = get_random_upgrade()
		upgrade_options.add_child(option_choice)
		options += 1
	get_tree().paused = true


func upgrade_character(upgrade):
	match upgrade:
		"slimeball_projectiles1", "slimeball_projectiles2", "slimeball_projectiles3":
			number_of_projectiles += 1
		"slimeball_range1","slimeball_range2", "slimeball_range3":
			shoot_distance += 100
		"slimeball_damage1", "slimeball_damage2", "slimeball_damage3":
			damage += 1
		"slimeball_speed1", "slimeball_speed2", "slimeball_speed3":
			projectile_speed += 100
		"slimeball_rate1", "slimeball_rate2", "slimeball_rate3":
			slime_shoot_timer.wait_time -= 0.25
		"slimeball_bounce1", "slimeball_bounce2", "slimeball_bounce3":
			number_of_bounces += 1

	var option_children = upgrade_options.get_children()
	for option in option_children:
		option.queue_free()
	new_upgrades.clear()
	collected_upgrades.append(upgrade)
	level_panel.visible = false
	get_tree().paused = false
	calculate_xp(0)


func get_random_upgrade():
	var database_list = []
	for upgrade in UpgradeDataBase.UPGRADES:
		if upgrade in collected_upgrades:
			pass
		elif upgrade in new_upgrades:
			pass
		elif UpgradeDataBase.UPGRADES[upgrade]["type"] == "item":
			pass
		elif UpgradeDataBase.UPGRADES[upgrade]["prerequisite"].size() > 0:
			var to_add = true
			for prereq in UpgradeDataBase.UPGRADES[upgrade]["prerequisite"]:
				if not prereq in collected_upgrades:
					to_add = false
			if to_add:
				database_list.append(upgrade)
		else:
			database_list.append(upgrade)
	
	if database_list.size() > 0:
		var random_upgrade = database_list.pick_random()
		new_upgrades.append(random_upgrade)
		return random_upgrade
	else:
		return null
