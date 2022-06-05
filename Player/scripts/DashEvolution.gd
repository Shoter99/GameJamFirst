extends WallJumpEvolution


class_name DashEvolution

var dashSpeed : int = 450
var isDashing : bool = false
var courutineActive : bool = false
export var tooMuchSpeedSlowdown : float = 1500

func friction(velocity, accelerating, isOnFloor, _isGliding, delta) -> Vector2:
	if accelerating == false:
		if isOnFloor == false:
			if velocity.x > 0:
				if velocity.x <= speed:
					if velocity.x - airResistance * delta >= 0:
						return Vector2(velocity.x - airResistance * delta, velocity.y)
					else:
						return Vector2(0, velocity.y)
				elif velocity.x > speed:
					if velocity.x - tooMuchSpeedSlowdown * delta >= speed:
						return Vector2(velocity.x - tooMuchSpeedSlowdown * delta, velocity.y)
					else:
						return Vector2(speed, velocity.y)
					
			elif velocity.x < 0:
				if velocity.x >= -speed:
					if velocity.x + airResistance * delta <= 0:
						return Vector2 (velocity.x + airResistance * delta, velocity.y)
					else:
						return Vector2 (0, velocity.y)
				elif velocity.x < -speed:
					if velocity.x + tooMuchSpeedSlowdown * delta <= speed:
						return Vector2(velocity.x + tooMuchSpeedSlowdown * delta, velocity.y)
					else:
						return Vector2 (-speed, velocity.y)
		else:
			if velocity.x > 0:
				if velocity.x <= speed:
					if velocity.x - floorFriction * delta >= 0:
						return Vector2(velocity.x - floorFriction * delta, velocity.y)
					else:
						return Vector2(0, velocity.y)
				elif velocity.x > speed:
					if velocity.x - tooMuchSpeedSlowdown * delta >= speed:
						return Vector2(velocity.x - tooMuchSpeedSlowdown * delta, velocity.y)
					else:
						return Vector2(speed, velocity.y)
			elif velocity.x < 0:
				if velocity.x >= -speed:
					if velocity.x + floorFriction * delta <= 0:
						return Vector2 (velocity.x + floorFriction * delta, velocity.y)
					else:
						return Vector2 (0, velocity.y)
				elif velocity.x < -speed:
					if velocity.x + tooMuchSpeedSlowdown * delta <= speed:
						return Vector2(velocity.x + tooMuchSpeedSlowdown * delta, velocity.y)
					else:
						return Vector2 (-speed, velocity.y)
	return velocity
		
	
func dash (velocity) -> Vector2:
	$Sprite.play("dash")
	if Input.is_action_pressed("move_left"):
		return Vector2 (-dashSpeed, 0)
	if Input.is_action_pressed("move_right"):
		return Vector2 (dashSpeed, 0)
	return velocity

func check_if_dashing() -> bool:
	if Input.is_action_pressed("move_left"):
		return true
	if Input.is_action_pressed("move_right"):
		return true
	return false
	
func evolution0_movement(delta : float) -> void:
	if isDashing == false:
		snapVector = disable_snap_vector()
		velocity = apply_movement(velocity, isOnFloor, whereWall, bullet, accelerating, delta)
		velocity = move_and_slide_with_snap(velocity, snapVector, Vector2.UP, true, maxSlides)
		isOnWall = is_player_on_wall(isGliding)
		if isOnWall:
			whereWall = check_where_wall()
		maxSlides = change_max_slides(isOnFloor)
		snapVector = Vector2.DOWN * 6
		isOnFloor = is_on_floor()
		if Input.is_action_just_pressed("Dash"):
			velocity = dash(velocity)
			isDashing = check_if_dashing()

	else:
		velocity = move_and_slide_with_snap(velocity, snapVector, Vector2.UP)
		isOnFloor = is_on_floor()
		isOnWall = is_player_on_wall(velocity)
		maxSlides = change_max_slides(isOnFloor)
		
func _physics_process(_delta) -> void:
	if courutineActive == false and isDashing == true:
		courutineActive = true
		yield(get_tree().create_timer(0.0001), "timeout")
		courutineActive = false
		isDashing = false


