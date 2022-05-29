extends Evolution0

class_name Evolution1

var swimSpeed : int = 5000


func water_movement(velocity, isOnWall, delta) -> Vector2:
	velocity = Vector2(0, 0)
	if Input.is_action_pressed("swim_right"):
		velocity.x = swimSpeed * delta
	if Input.is_action_pressed("swim_left"):
		velocity.x = -swimSpeed * delta
	if Input.is_action_pressed("swim_up"):
		velocity.y = -swimSpeed * delta
	if Input.is_action_pressed("swim_down"):
		velocity.y = swimSpeed * delta
	return velocity

func evolution1_movement(delta) -> void:
	velocity = water_movement(velocity, isOnWall, delta)
	if Input.is_action_just_pressed("fire"):
		fire(bullet)
	velocity = move_and_slide(velocity)


func _physics_process(delta : float):
	if inWater:
		evolution1_movement(delta)
