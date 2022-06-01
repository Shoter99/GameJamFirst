extends Position2D

export var isOn = true
export var id := int(1)

func _on_SpawnPointHitbox_body_entered(body):
	if body.is_in_group("Player"):
		if isOn:
			Global.currentCheckpoint = id
