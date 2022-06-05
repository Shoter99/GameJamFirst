extends SwimEvolution


class_name DoubleJumpEvolution

func _ready() -> void:
	Global.set_start_options(5, 55)

func jump(velocity, _isOnFloor) -> Vector2:
	if Input.is_action_just_pressed("jump"):
		$Sprite.play("idle")
		$Sprite.play("jump")
		return Vector2(velocity.x, jumpSpeed)
	return velocity

func apply_jump(_whereWall, velocity, jumpsRemaining) -> Vector2:
	if Input.is_action_just_pressed("jump") and jumpsRemaining > 0:
		$Sprite.play("idle")
		$Sprite.play("2ndJump")
		return jump(velocity, isOnFloor)
	return velocity

func change_jumps(jumpsRemaining, isOnFloor, _isOnWall) -> int:
	if isOnFloor:
		jumpsRemaining = 2
	if Input.is_action_just_pressed("jump") and jumpsRemaining > 0:
		$Sprite.play("idle")
		$Sprite.play("jump")
		jumpsRemaining -= 1
	return jumpsRemaining

func get_input(velocity, isOnFloor, whereWall, _bullet, jumpsRemaining, delta) -> Vector2:
	play_animations(velocity)
	velocity = apply_gravity(velocity, isOnWall, isOnFloor, isGliding, delta)
	velocity = movement(delta, velocity, isOnWall)
	velocity = apply_jump(whereWall, velocity, jumpsRemaining)
	return velocity
