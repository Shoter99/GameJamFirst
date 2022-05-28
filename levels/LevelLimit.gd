extends Area2D




func _on_LevelLimit_body_entered(body):
	if body.name == "Player":
		Global.restart_level()
