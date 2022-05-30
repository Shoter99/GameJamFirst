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

func water_movement(velocity, delta) -> Vector2:
	if Input.is_action_pressed("swim_right") and velocity.x < swimSpeed:
		if velocity.x >= 0:
			velocity.x += acceleration * delta
		else:
			velocity.x += directionChangeSpeed * delta
	if Input.is_action_pressed("swim_left") and velocity.x > -swimSpeed:
		if velocity.x <= 0:
			velocity.x -= acceleration * delta
		else:
			velocity.x -= directionChangeSpeed * delta
	if Input.is_action_pressed("swim_up") and velocity.y > -swimSpeed:
		if velocity.y <= 0:
			velocity.y -= acceleration * delta
		else:
			velocity.y -= directionChangeSpeed * delta
	if Input.is_action_pressed("swim_down") and velocity.y < swimSpeed:
		if velocity.y >= 0:
			velocity.y += acceleration * delta
		else:
			velocity.y += directionChangeSpeed * delta

		
	if Input.is_action_pressed("swim_right") == false and Input.is_action_pressed("swim_left") == false:
		if velocity.x > 0:
			velocity.x -= deceleration* delta
		elif velocity.x < 0:
			velocity.x += deceleration * delta
	if Input.is_action_pressed("swim_up") == false and Input.is_action_pressed("swim_down") == false:
		if velocity.y > 0:
			velocity.y -= deceleration * delta
		elif velocity.y < 0:
			velocity.y += deceleration * delta
		
	velocity = move_and_slide(velocity)
	
	fire(bullet)
	
	return velocity

