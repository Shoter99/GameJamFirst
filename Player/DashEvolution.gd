extends FireEvolution

class_name DashEvolution

var dashSpeed : int = 450
var isDashing : bool = false
var courutineActive : bool = false

func friction(velocity, accelerating, isOnFloor, delta) -> Vector2:
	if accelerating == false:
		if isOnFloor == false:
			if velocity.x > 0:
				if velocity.x <= speed:
					if velocity.x - 60 * delta >= 0:
						return Vector2(velocity.x - 60 * delta, velocity.y)
					else:
						return Vector2(0, velocity.y)
				elif velocity.x > speed:
					if velocity.x - 1500 * delta >= speed:
						return Vector2(velocity.x - 1500 * delta, velocity.y)
					else:
						return Vector2(speed, velocity.y)
					
			elif velocity.x < 0:
				if velocity.x >= -speed:
					if velocity.x + 60 * delta <= 0:
						return Vector2 (velocity.x + 60 * delta, velocity.y)
					else:
						return Vector2 (0, velocity.y)
				elif velocity.x < -speed:
					if velocity.x + 1500 * delta <= speed:
						return Vector2(velocity.x + 1500 * delta, velocity.y)
					else:
						return Vector2 (-speed, velocity.y)
		else:
			if velocity.x > 0:
				if velocity.x <= speed:
					if velocity.x - 600 * delta >= 0:
						return Vector2(velocity.x - 600 * delta, velocity.y)
					else:
						return Vector2(0, velocity.y)
				elif velocity.x > speed:
					if velocity.x - 1500 * delta >= speed:
						return Vector2(velocity.x - 1500 * delta, velocity.y)
					else:
						return Vector2(speed, velocity.y)
			elif velocity.x < 0:
				if velocity.x >= -speed:
					if velocity.x + 600 * delta <= 0:
						return Vector2 (velocity.x + 600 * delta, velocity.y)
					else:
						return Vector2 (0, velocity.y)
				elif velocity.x < -speed:
					if velocity.x + 1500 * delta <= speed:
						return Vector2(velocity.x + 1500 * delta, velocity.y)
					else:
						return Vector2 (-speed, velocity.y)
	return velocity
		
	
func dash (velocity) -> Vector2:
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
	
func evolution0_movement(delta):
	if isDashing == false:
		snapVector = disable_snap_vector()
		velocity = apply_movement(velocity, isOnFloor, isOnWall, whereWall, bullet, accelerating, delta)
		velocity = move_and_slide_with_snap(velocity, snapVector, Vector2.UP)
		snapVector = Vector2.DOWN * 6
		isOnFloor = is_on_floor()
		isOnWall = is_player_on_wall()
		if isOnWall:
			whereWall = check_where_wall()
		if Input.is_action_just_pressed("Dash"):
			velocity = dash(velocity)
			isDashing = check_if_dashing()

	else:
		velocity = move_and_slide_with_snap(velocity, snapVector, Vector2.UP)
		isOnFloor = is_on_floor()
		isOnWall = is_player_on_wall()
		
func _physics_process(_delta):
	if courutineActive == false and isDashing == true:
		courutineActive = true
		yield(get_tree().create_timer(0.0001), "timeout")
		courutineActive = false
		isDashing = false


