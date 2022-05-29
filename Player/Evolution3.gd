extends Evolution2

class_name Evolution3

onready var bullet: = preload("res://Player/Bullet.tscn")

func fire(bullet) -> void:
	var bulletInstance = bullet.instance()
	owner.add_child(bulletInstance)
	if get_node("Sprite").flip_h:
		bulletInstance.set_global_position($MeleeLeft.get_global_position())
		bulletInstance.speed = -250
	else:
		bulletInstance.set_global_position($MeleeRight.get_global_position())
		bulletInstance.get_node("Sprite").set_flip_h(true)

func _physics_process(delta : float):
	if Input.is_action_just_pressed("fire"):
		fire(bullet)
