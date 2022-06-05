extends Position2D

export var isOn = true
export var id := int(1)

var isNear := false

func _on_SpawnPointHitbox_body_entered(body):
	if body.is_in_group("Player"):
		if Global.canEvolve:
			isNear = true
			$Label.visible = true
		if isOn:
			Global.currentCheckpoint = id
		


func _on_SpawnPointHitbox_body_exited(body):
	if body.is_in_group("Player"):
		isNear = false
		if $Label.visible:
			$Label.visible = false

func _unhandled_input(event):
	if isNear:
		if event.is_action_pressed("evolve"):
			Global.go_to_next_evolution()
