extends Position2D

export var isOn = true
export var id := int(1)

var isNear := false

func _ready():
	deactivate()

func _on_SpawnPointHitbox_body_entered(body):
	if body.is_in_group("Player"):
		if Global.canEvolve:
			if Global.currentEvolutionNo != 7:
				isNear = true
				$Label.visible = true
		if isOn:
			activate()
			Global.currentCheckpoint = id
		
func activate():
	$Sprite.play("a")

func deactivate():
	$Sprite.play("na")

func _on_SpawnPointHitbox_body_exited(body):
	if body.is_in_group("Player"):
		isNear = false
		if $Label.visible:
			$Label.visible = false

func _unhandled_input(event):
	if isNear:
		if event.is_action_pressed("evolve"):
			Global.go_to_next_evolution()
