extends Position2D

var isActive = false
export var id := int(1)

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		Global.currentLevel -=1
		Global.spawnAtEnd = true
		get_tree().change_scene(Global.levels[Global.currentLevel])
