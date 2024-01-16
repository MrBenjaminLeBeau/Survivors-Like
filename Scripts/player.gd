extends CharacterBody2D

signal health_depleted

var health = 100.0


func _physics_process(delta):
	

	const DAMAGE_RATE = 500.0
	var overlapping_mobs = %HitBox.get_overlapping_bodies()
	
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%HealthBar.value = health
		
		if health <= 0:
			health_depleted.emit()
	
