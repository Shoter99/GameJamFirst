extends NoEvolution


class_name JumpEvolution
var jumpSpeed : int = -200

func disable_snap_vector() -> Vector2:
	if Input.is_action_just_pressed("jump"):
		return Vector2 (0, 0)
	return Vector2.DOWN * 6

func jump(velocity, isOnFloor) -> Vector2:
	if Input.is_action_just_pressed("jump") and isOnFloor:
		return Vector2(velocity.x, jumpSpeed)
	return velocity


func get_input(velocity, isOnFloor, _isOnWall, _whereWall, _bullet, _jumpsRemaining, delta) -> Vector2:
	play_animations(velocity)
	if isOnFloor == false:
		velocity = apply_gravity(velocity, isOnFloor, delta)
	velocity = movement(delta, isOnWall, velocity)
	velocity = jump(velocity, isOnFloor)
	return velocity
	
func evolution0_movement(delta):
	snapVector = disable_snap_vector()
	velocity = apply_movement(velocity, isOnFloor, isOnWall, whereWall, bullet, accelerating, delta)
	velocity = move_and_slide_with_snap(velocity, snapVector, Vector2.UP)
	snapVector = Vector2.DOWN * 6
	isOnFloor = is_on_floor()
	isOnWall = is_player_on_wall()


