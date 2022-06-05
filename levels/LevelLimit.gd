extends Area2D


func _on_LevelLimit_body_entered(body):
	if body.is_in_group("Player"):
		Global.restart_level()
