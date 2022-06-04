extends DashEvolution

class_name GlideEvolution

var glideStrength : float = gravity/10

func friction(velocity, accelerating, isOnFloor, isGliding, delta) -> Vector2:
	if accelerating == false:
		if isGliding == false:
			if isOnFloor == false:
				if velocity.x > 0:
					if velocity.x <= speed:
						if velocity.x - airResistance * delta >= 0:
							return Vector2(velocity.x - airResistance * delta, velocity.y)
						else:
							return Vector2(0, velocity.y)
					elif velocity.x > speed:
						if velocity.x - self.tooMuchSpeedSlowdown * delta >= speed:
							return Vector2(velocity.x - self.tooMuchSpeedSlowdown * delta, velocity.y)
						else:
							return Vector2(speed, velocity.y)
				elif velocity.x < 0:
					if velocity.x >= -speed:
						if velocity.x + airResistance * delta <= 0:
							return Vector2 (velocity.x + airResistance * delta, velocity.y)
						else:
							return Vector2 (0, velocity.y)
					elif velocity.x < -speed:
						if velocity.x + self.tooMuchSpeedSlowdown * delta <= speed:
							return Vector2(velocity.x + self.tooMuchSpeedSlowdown * delta, velocity.y)
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
						if velocity.x - self.tooMuchSpeedSlowdown * delta >= speed:
							return Vector2(velocity.x - self.tooMuchSpeedSlowdown * delta, velocity.y)
						else:
							return Vector2(speed, velocity.y)
				elif velocity.x < 0:
					if velocity.x >= -speed:
						if velocity.x + floorFriction * delta <= 0:
							return Vector2 (velocity.x + floorFriction * delta, velocity.y)
						else:
							return Vector2 (0, velocity.y)
					elif velocity.x < -speed:
						if velocity.x + self.tooMuchSpeedSlowdown * delta <= speed:
							return Vector2(velocity.x + self.tooMuchSpeedSlowdown * delta, velocity.y)
						else:
							return Vector2 (-speed, velocity.y)
		else:
			if velocity.x > 0:
				if velocity.x <= speed:
					if velocity.x - airResistance * delta * 10 >= 0:
						return Vector2(velocity.x - airResistance * delta * 10, velocity.y)
					else:
						return Vector2(0, velocity.y)
				elif velocity.x > speed:
					if velocity.x - self.tooMuchSpeedSlowdown * delta * 10 >= speed:
						return Vector2(velocity.x - self.tooMuchSpeedSlowdown * delta * 10, velocity.y)
					else:
						return Vector2(speed, velocity.y)
			elif velocity.x < 0:
				if velocity.x >= -speed:
					if velocity.x + airResistance * delta * 10 <= 0:
						return Vector2 (velocity.x + airResistance * delta * 10, velocity.y)
					else:
						return Vector2 (0, velocity.y)
				elif velocity.x < -speed:
					if velocity.x + self.tooMuchSpeedSlowdown * delta * 10 <= speed:
						return Vector2(velocity.x + self.tooMuchSpeedSlowdown * delta * 10, velocity.y)
					else:
						return Vector2 (-speed, velocity.y)
	return velocity

func evolution0_movement(delta) -> void:
	if self.isDashing == false:
		snapVector = disable_snap_vector()
		velocity = apply_movement(velocity, isOnFloor, whereWall, bullet, accelerating, delta)
		velocity = move_and_slide_with_snap(velocity, snapVector, Vector2.UP, true, maxSlides)
		snapVector = Vector2.DOWN * 6
		isOnWall = is_player_on_wall(isGliding)
		if isOnWall:
			whereWall = check_where_wall()
		maxSlides = change_max_slides(isOnFloor)
		isOnFloor = is_on_floor()
#		if Input.is_action_just_pressed("Dash") and isGliding == false:
#			velocity = self.dash(velocity)
#			isDashing = check_if_dashing()

func is_player_on_wall(isGliding) -> bool:
	if is_on_floor():
		lastWall = "nothing"
		return false
	elif is_on_wall() and isGliding == false:
		return true
	else:
		$Sprite.play("jump")
		return false

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
	onWallFirstTime = true
	if isGliding:
		return Vector2(velocity.x, glideStrength)
	return Vector2(velocity.x, velocity.y + gravity * delta)

func _physics_process(_delta : float) -> void:
	if Input.is_action_pressed("glide") and isOnFloor == false and velocity.y > 0:
		isGliding = true
	else:
		isGliding = false


