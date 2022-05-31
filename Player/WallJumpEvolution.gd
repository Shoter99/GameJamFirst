extends DoubleJumpEvolution


class_name WallJumpEvolution

var waitingForJump : bool = false
var canJump : bool = false
var waitTime : float = 0.15


func rightJumpCourutine():
	yield(get_tree().create_timer(waitTime), "timeout")
	if Input.is_action_pressed("move_right"):
		canJump = true
	waitingForJump = false
		
func leftJumpCourutine():
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
		if Input.is_action_pressed("move_right") and Input.is_action_just_pressed("release"):
			return move_right(delta, velocity)
		elif Input.is_action_pressed("move_left") and Input.is_action_just_pressed("release"):
			return move_left(delta, velocity)

	return velocity
	
func change_jumps(jumpsRemaining, isOnFloor, _isOnWall) -> int:
	if isOnFloor or isOnWall:
		jumpsRemaining = 2
	if Input.is_action_just_pressed("jump") and jumpsRemaining > 0:
		jumpsRemaining -= 1
	return jumpsRemaining

func check_where_wall():
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

func apply_gravity(velocity, isOnWall, isOnFloor, delta) -> Vector2:
	if isOnWall:
		return Vector2 (0, 0)
	return Vector2(velocity.x, velocity.y + gravity * delta)

func jump_on_wall(whereWall, velocity) -> Vector2:
	velocity = jump(velocity, isOnFloor)
	velocity.x = velocity.x * 1.5
	if whereWall == "right":
		velocity.x = -speed * 1.2
	elif whereWall == "left":
		velocity.x = speed * 1.2
	return velocity

func release_from_wall(whereWall, velocity) -> Vector2:
	if whereWall == "right":
		return Vector2(-speed*.1, velocity.y)
	elif whereWall == "left":
		return Vector2(speed*.1, velocity.y)
	return velocity

func apply_jump(whereWall, velocity, jumpsRemaining):
	if Input.is_action_just_pressed("jump") and jumpsRemaining > 0 and isOnWall == false:
		velocity = jump(velocity, isOnFloor)
	if isOnWall:
		if Input.is_action_just_pressed("release") or canJump:
			canJump = false
			return release_from_wall(whereWall, velocity)
		if Input.is_action_just_pressed("jump"):
			return jump_on_wall(whereWall, velocity)
		if Input.is_action_just_pressed("move_left") and whereWall == "right" and waitingForJump == false:
			waitingForJump = true
			leftJumpCourutine()			
		if Input.is_action_just_pressed("move_right") and whereWall == "left" and waitingForJump == false:
			waitingForJump = true
			rightJumpCourutine()
			
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


