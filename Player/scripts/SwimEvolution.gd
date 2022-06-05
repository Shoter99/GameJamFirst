extends JumpEvolution


class_name SwimEvolution
var swimSpeed : int = 150
var acceleration : float = 200
var deceleration : float = 300
var directionChangeSpeed : float = 700
var isWaterFliped = false

func _ready() -> void:
	canSwim = true
	Global.set_start_options(4, 50)
	
func water_movement(velocity, delta) -> Vector2:
	if Input.is_action_pressed("swim_right") and velocity.x < swimSpeed:
		if velocity.x >= 0:
			if velocity.x + acceleration * delta <= swimSpeed:
				velocity.x += acceleration * delta
			else:
				velocity.x = swimSpeed
		else:
			velocity.x += directionChangeSpeed * delta

	if Input.is_action_pressed("swim_left") and velocity.x > -swimSpeed:
		if velocity.x <= 0:
			if velocity.x - acceleration * delta >= -swimSpeed:
				velocity.x -= acceleration * delta
			else:
				velocity.x = -swimSpeed
		else:
			velocity.x -= directionChangeSpeed * delta

	if Input.is_action_pressed("swim_up") and velocity.y > -swimSpeed:
		if velocity.y <= 0:
			if velocity.y - acceleration * delta >= -swimSpeed:
				velocity.y -= acceleration * delta
			else:
				velocity.y = -swimSpeed
		else:
			velocity.y -= directionChangeSpeed * delta

	if Input.is_action_pressed("swim_down") and velocity.y < swimSpeed:
		if velocity.y >= 0:
			if velocity.y + acceleration * delta <= swimSpeed:
				velocity.y += acceleration * delta
			else:
				velocity.y = swimSpeed
		else:
			velocity.y += directionChangeSpeed * delta

	if Input.is_action_pressed("swim_right") == false and Input.is_action_pressed("swim_left") == false and velocity.x != 0:
		if velocity.x > 0:
			if velocity.x - deceleration * delta >= 0:
				velocity.x -= deceleration* delta
			else:
				velocity.x = 0
		else:
			if velocity.x + deceleration * delta <= 0:
				velocity.x += deceleration * delta
			else:
				velocity.x = 0

	if Input.is_action_pressed("swim_up") == false and Input.is_action_pressed("swim_down") == false and velocity.y != 0:
		if velocity.y > 0:
			if velocity.y - deceleration * delta >= 0:
				velocity.y -= deceleration * delta
			else:
				velocity.y = 0
		else:
			if velocity.y + deceleration * delta <= 0:
				velocity.y += deceleration * delta
			else:
				velocity.y = 0

	if velocity.x > 0:
		flip_right()
	elif velocity.x < 0:
		flip_left()

	velocity = move_and_slide(velocity)
	return velocity
