extends DoubleJumpEvolution


class_name WallJumpEvolution

func movement(delta, isOnWall, velocity) -> Vector2:
	if isOnWall == false:
		if Input.is_action_pressed("move_right") and velocity.x <= speed:
			return move_right(delta, velocity)
		elif Input.is_action_pressed("move_left") and velocity.x >= -speed:
			return move_left(delta, velocity)
		elif velocity.x >= -speed/4 and velocity.x <= speed/4:
			return Vector2 (0, velocity.y)
	else:
		if Input.is_action_pressed("move_right") and Input.is_action_just_pressed("release"):
			return move_right(delta, velocity)
		elif Input.is_action_pressed("move_left") and Input.is_action_just_pressed("release"):
			return move_left(delta, velocity)

	return velocity
	
func change_jumps(jumpsRemaining, isOnFloor, isOnWall) -> int:
	if isOnFloor or isOnWall:
		jumpsRemaining = 2
	if Input.is_action_just_pressed("jump") and jumpsRemaining > 0:
		jumpsRemaining -= 1
	return jumpsRemaining

func check_where_wall():
	for i in range (get_slide_count()):
		if get_slide_collision(i):
			if get_slide_collision(i).position.x > get_position().x:
				$Sprite.play("on_wall")
				get_node("Sprite").set_flip_h(true)
				return "right"
			else:
				$Sprite.play("on_wall")
				get_node("Sprite").set_flip_h(false)
				return "left"

func apply_gravity(velocity, isOnWall, delta) -> Vector2:
	if isOnWall:
		return Vector2 (0, 0)
	else:
		return Vector2(velocity.x, velocity.y + gravity * delta)

func jump_on_wall(whereWall, velocity) -> Vector2:
	velocity = jump(velocity, isOnFloor)
	if whereWall == "right":
		velocity.x = -speed * .1
	elif whereWall == "left":
		velocity.x = speed * .1
	return velocity

func release_from_wall(whereWall, velocity) -> Vector2:
	if whereWall == "right":
		return Vector2(-speed*.1, velocity.y)
	elif whereWall == "left":
		return Vector2(speed*.1, velocity.y)
	return velocity

func jump_away_from_wall(whereWall, velocity):
	if Input.is_action_pressed("move_left") and whereWall == "right":
		velocity.x = -speed * 1
		velocity = jump(velocity, isOnFloor)
		return velocity
	if Input.is_action_pressed("move_right") and whereWall == "left":
		velocity.x = speed * .1
		velocity = jump(velocity, isOnFloor)
		return velocity
	return velocity

func apply_jump(whereWall, velocity, jumpsRemaining):
	if Input.is_action_just_pressed("jump") and jumpsRemaining > 0 and isOnWall == false:
		velocity = jump(velocity, isOnFloor)
	if isOnWall:
		if Input.is_action_just_pressed("release"):
			return release_from_wall(whereWall, velocity)
		if Input.is_action_just_pressed("jump") and Input.is_action_pressed("move_left") and whereWall == "right":
			return jump_away_from_wall(whereWall, velocity)
		if Input.is_action_just_pressed("jump") and Input.is_action_pressed("move_right") and whereWall == "left":
			return jump_away_from_wall(whereWall, velocity)
		if Input.is_action_just_pressed("jump"):
			return jump_on_wall(whereWall, velocity)
	return velocity
	
func evolution0_movement(delta):
	snapVector = disable_snap_vector()
	velocity = apply_movement(velocity, isOnFloor, isOnWall, whereWall, bullet, accelerating, delta)
	velocity = move_and_slide_with_snap(velocity, snapVector, Vector2.UP)
	snapVector = Vector2.DOWN * 6
	isOnFloor = is_on_floor()
	isOnWall = is_player_on_wall()
	if isOnWall:
		whereWall = check_where_wall()


