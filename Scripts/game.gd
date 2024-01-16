extends Node2D


func _on_player_slime_health_depleted():
	$GameOver.visible = true
	get_tree().paused = true
