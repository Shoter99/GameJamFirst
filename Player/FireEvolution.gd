extends WallJumpEvolution

class_name FireEvolution

func fire(bullet) -> void:
	if Input.is_action_just_pressed("fire"):
		var bulletInstance = bullet.instance()
		get_tree().root.add_child(bulletInstance)
		if get_node("Sprite").flip_h:
			bulletInstance.set_global_position($MeleeLeft.get_global_position())
			bulletInstance.speed = -250	
		else:
			bulletInstance.set_global_position($MeleeRight.get_global_position())
			bulletInstance.get_node("Sprite").set_flip_h(true)
		
func get_input(velocity, isOnFloor, isOnWall, whereWall, bullet, jumpsRemaining, delta) -> Vector2:
	play_animations(velocity)
	fire(bullet)
	if isOnFloor == false:
		velocity = apply_gravity(velocity, isOnWall, delta)
	velocity = movement(delta, isOnWall, velocity)
	velocity = apply_jump(whereWall, velocity, jumpsRemaining)
	return velocity

