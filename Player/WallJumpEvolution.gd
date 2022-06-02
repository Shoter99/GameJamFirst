extends DoubleJumpEvolution


class_name WallJumpEvolution

var waitingForJump : bool = false
var canJump : bool = false
var onWallFirstTime : bool = true
var waitTime : float = 0.15
var wallFriction : float = -40

func change_max_slides(isOnFloor) -> int:
	if isOnFloor and isOnWall == false:
		return 4
	else:
		return 1

func is_player_on_wall(_isGliding) -> bool:
	if is_on_floor():
		lastWall = "nothing"
		return false
	elif is_on_wall():
		return true
	else:
		$Sprite.play("jump")
		return false


func rightJumpCourutine() -> void:
	yield(get_tree().create_timer(waitTime), "timeout")
	if Input.is_action_pressed("move_right"):
		canJump = true
	waitingForJump = false
		
func leftJumpCourutine() -> void:
	yield(get_tree().create_timer(waitTime), "timeout")
	if Input.is_action_pressed("move_left"):
		canJump = true
	waitingForJump = false

func movement(delta, velocity, isOnWall) -> Vector2:
	if isOnWall == false:
		if Input.is_action_pressed("move_right") and velocity.x <= speed:
			return move_right(delta, velocity)
		elif Input.is_action_pressed("move_left") and velocity.x >= -speed:
			return move_left(delta, velocity)
	else:
		if Input.is_action_pressed("move_right") and Input.is_action_pressed("release"):
			return move_right(delta, velocity)
		elif Input.is_action_pressed("move_left") and Input.is_action_pressed("release"):
			return move_left(delta, velocity)

	return velocity
	
func change_jumps(jumpsRemaining, isOnFloor, _isOnWall) -> int:
	if isOnFloor or isOnWall:
		jumpsRemaining = 2
	if Input.is_action_just_pressed("jump") and jumpsRemaining > 0:
		jumpsRemaining -= 1
	return jumpsRemaining

func check_where_wall() -> String:
	if inWater:
		return "nothing"
	else:
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
	return "nothing"

func apply_gravity(velocity, isOnWall, _isOnFloor, _isGliding, delta) -> Vector2:
	if isOnWall:
		if onWallFirstTime:
			onWallFirstTime = false
			if whereWall == "right":
				return Vector2 (3, 0)
			return Vector2 (-3, 0)
		else:
			if whereWall == "right":
				return Vector2 (3, velocity.y - wallFriction * delta)
			return Vector2 (-3, velocity.y - wallFriction * delta)
		#return Vector2(0, 0)
	onWallFirstTime = true
	return Vector2(velocity.x, velocity.y + gravity * delta)

func jump_on_wall(whereWall, velocity) -> Vector2:
	lastWall = whereWall
	velocity = jump(velocity, isOnFloor)
	velocity.x = velocity.x * 1.6
	if whereWall == "right":
		lastWall = "right"
		velocity.x = -speed * 1.4
	elif whereWall == "left":
		lastWall = "left"
		velocity.x = speed * 1.4
	return velocity

func release_from_wall(whereWall, velocity) -> Vector2:
	if whereWall == "right":
		return Vector2(-speed*.1, velocity.y)
	elif whereWall == "left":
		return Vector2(speed*.1, velocity.y)
	return velocity

func apply_jump(whereWall, velocity, jumpsRemaining) -> Vector2:
	if Input.is_action_just_pressed("jump") and jumpsRemaining > 0 and isOnWall == false:
		velocity = jump(velocity, isOnFloor)
	if isOnWall:
		if Input.is_action_just_pressed("release") or canJump:
			canJump = false
			return release_from_wall(whereWall, velocity)
		if Input.is_action_just_pressed("jump") and whereWall != lastWall:
			return jump_on_wall(whereWall, velocity)
		if Input.is_action_pressed("move_left") and whereWall == "right" and waitingForJump == false:
			waitingForJump = true
			leftJumpCourutine()
		if Input.is_action_pressed("move_right") and whereWall == "left" and waitingForJump == false:
			waitingForJump = true
			rightJumpCourutine()
			
	return velocity
	
func evolution0_movement(delta) -> void:
	snapVector = disable_snap_vector()
	velocity = apply_movement(velocity, isOnFloor, isOnWall, whereWall, bullet, accelerating, delta)
	velocity = move_and_slide_with_snap(velocity, snapVector, Vector2.UP, true, maxSlides, deg2rad(45), false)
	snapVector = Vector2.DOWN * 6
	isOnFloor = is_on_floor()
	isOnWall = is_player_on_wall(isGliding)
	if isOnWall:
		whereWall = check_where_wall()
	maxSlides = change_max_slides(isOnFloor)


