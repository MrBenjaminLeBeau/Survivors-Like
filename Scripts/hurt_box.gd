extends Area2D

@export_enum("Coolsown", "HitOnce", "DisableHitBox") var hurt_box_type = 0

@onready var collision = $CollisionShape2D
@onready var disable_timer = $DisableTimer

signal hurt(damage)


func _on_area_entered(area):
	if area.is_in_group("attack"):
		if not area.get("damage") == null:
			match hurt_box_type:
				0: # Cooldown
					collision.call_deferred("set", "disabled", true)
					disable_timer.start()
				1: # Hit Once
					pass
				2: # Disable Hit Box
					if area.has_method("temp_disabled"):
						area.temp_disabled()
			var damage = area.damage
			emit_signal("hurt", damage)
			if area.has_method("enemy_hit"):
				area.enemy_hit(1)


func _on_disable_timer_timeout():
	collision.call_deferred("set", "disabled", false)
