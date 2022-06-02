extends GlideEvolution


class_name WallClimbEvolution

func jump_on_wall(whereWall, velocity) -> Vector2:
	lastWall = whereWall
	velocity = jump(velocity, isOnFloor)
	velocity.x = velocity.x * 1.6
	if whereWall == "right":
		velocity.x = -speed * 1.4
	elif whereWall == "left":
		velocity.x = speed * 1.4
	return velocity

func apply_jump(whereWall, velocity, jumpsRemaining) -> Vector2:
	if Input.is_action_just_pressed("jump") and jumpsRemaining > 0 and isOnWall == false:
		velocity = jump(velocity, isOnFloor)
	if isOnWall:
		if Input.is_action_just_pressed("release") or canJump:
			canJump = false
			return release_from_wall(whereWall, velocity)
		if Input.is_action_just_pressed("jump"):
			return jump_on_wall(whereWall, velocity)
		if Input.is_action_pressed("move_left") and whereWall == "right" and waitingForJump == false:
			waitingForJump = true
			leftJumpCourutine()
		if Input.is_action_pressed("move_right") and whereWall == "left" and waitingForJump == false:
			waitingForJump = true
			rightJumpCourutine()
	return velocity

func is_player_on_wall(isGliding) -> bool:
	if is_on_floor():
		return false
	elif is_on_wall() and isGliding == false:
		return true
	else:
		$Sprite.play("jump")
		return false
