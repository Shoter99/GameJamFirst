extends DashEvolution


class_name FireEvolution

func fire(bullet) -> void:
	if Input.is_action_just_pressed("fire"):
		var bulletInstance = bullet.instance()
		get_tree().root.add_child(bulletInstance)
		print(bulletInstance)
		if get_node("Sprite").flip_h:
			bulletInstance.set_global_position($FireLeft.get_global_position())
			bulletInstance.speed = -250	
		else:
			bulletInstance.set_global_position($FireRight.get_global_position())
			bulletInstance.get_node("Sprite").set_flip_h(true)
		
func get_input(velocity, isOnFloor, whereWall, bullet, jumpsRemaining, delta) -> Vector2:
	play_animations(velocity)
	fire(bullet)
	velocity = apply_gravity(velocity, isOnWall, isOnFloor, isGliding, delta)
	velocity = movement(delta, velocity, isOnWall)
	velocity = apply_jump(whereWall, velocity, jumpsRemaining)
	return velocity

func water_movement(velocity, delta) -> Vector2:
	if Input.is_action_pressed("swim_right") and velocity.x < swimSpeed:
		if velocity.x >= 0:
			if velocity.x + acceleration * delta <= swimSpeed:
				velocity.x += acceleration * delta
			else:
				velocity.x = swimSpeed
		else:
			velocity.x += directionChangeSpeed * delta

	if Input.is_action_pressed("swim_left") and velocity.x > -swimSpeed:
		if velocity.x <= 0:
			if velocity.x - acceleration * delta >= -swimSpeed:
				velocity.x -= acceleration * delta
			else:
				velocity.x = -swimSpeed
		else:
			velocity.x -= directionChangeSpeed * delta

	if Input.is_action_pressed("swim_up") and velocity.y > -swimSpeed:
		if velocity.y <= 0:
			if velocity.y - acceleration * delta >= -swimSpeed:
				velocity.y -= acceleration * delta
			else:
				velocity.y = -swimSpeed
		else:
			velocity.y -= directionChangeSpeed * delta

	if Input.is_action_pressed("swim_down") and velocity.y < swimSpeed:
		if velocity.y >= 0:
			if velocity.y + acceleration * delta <= swimSpeed:
				velocity.y += acceleration * delta
			else:
				velocity.y = swimSpeed
		else:
			velocity.y += directionChangeSpeed * delta

	if Input.is_action_pressed("swim_right") == false and Input.is_action_pressed("swim_left") == false and velocity.x != 0:
		if velocity.x > 0:
			if velocity.x - deceleration * delta >= 0:
				velocity.x -= deceleration* delta
			else:
				velocity.x = 0
		else:
			if velocity.x + deceleration * delta <= 0:
				velocity.x += deceleration * delta
			else:
				velocity.x = 0

	if Input.is_action_pressed("swim_up") == false and Input.is_action_pressed("swim_down") == false and velocity.y != 0:
		if velocity.y > 0:
			if velocity.y - deceleration * delta >= 0:
				velocity.y -= deceleration * delta
			else:
				velocity.y = 0
		else:
			if velocity.y + deceleration * delta <= 0:
				velocity.y += deceleration * delta
			else:
				velocity.y = 0

	velocity = move_and_slide(velocity)
	fire(bullet)
	return velocity

