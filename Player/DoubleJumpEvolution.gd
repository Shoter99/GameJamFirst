extends SwimEvolution


class_name DoubleJumpEvolution

func _ready():
	Global.set_start_options(5, 30)
	
func jump(velocity, _isOnFloor) -> Vector2:
	if Input.is_action_just_pressed("jump"):
		return Vector2(velocity.x, jumpSpeed)
	return velocity

func apply_jump(_whereWall, velocity, jumpsRemaining):
	if Input.is_action_just_pressed("jump") and jumpsRemaining > 0:
		velocity = jump(velocity, isOnFloor)
	return velocity
	
func change_jumps(jumpsRemaining, isOnFloor, isOnWall) -> int:
	if isOnFloor:
		jumpsRemaining = 2
	if Input.is_action_just_pressed("jump") and jumpsRemaining > 0:
		jumpsRemaining -= 1
	return jumpsRemaining

func get_input(velocity, isOnFloor, isOnWall, whereWall, _bullet, jumpsRemaining, delta) -> Vector2:
	play_animations(velocity)
	if isOnFloor == false:
		velocity = apply_gravity(velocity, isOnWall, delta)
	velocity = movement(delta, isOnWall, velocity)
	velocity = apply_jump(whereWall, velocity, jumpsRemaining)
	return velocity

func _physics_process(delta : float):
	yield(get_tree().create_timer(delta), "timeout")
	jumpsRemaining = change_jumps(jumpsRemaining, isOnFloor, isOnWall)
	

