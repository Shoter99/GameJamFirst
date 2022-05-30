extends JumpEvolution

class_name SwimEvolution

var swimSpeed : int = 150

var acceleration : float = 200
var deceleration : float = 300
var directionChangeSpeed : float = 700

func _ready():
	Global.set_start_options(4, 20)
	
func water_movement(velocity, delta) -> Vector2:
	if Input.is_action_pressed("swim_right") and velocity.x < swimSpeed:
		if velocity.x >= 0:
			velocity.x += acceleration * delta
		else:
			velocity.x += directionChangeSpeed * delta
	if Input.is_action_pressed("swim_left") and velocity.x > -swimSpeed:
		if velocity.x <= 0:
			velocity.x -= acceleration * delta
		else:
			velocity.x -= directionChangeSpeed * delta
	if Input.is_action_pressed("swim_up") and velocity.y > -swimSpeed:
		if velocity.y <= 0:
			velocity.y -= acceleration * delta
		else:
			velocity.y -= directionChangeSpeed * delta
	if Input.is_action_pressed("swim_down") and velocity.y < swimSpeed:
		if velocity.y >= 0:
			velocity.y += acceleration * delta
		else:
			velocity.y += directionChangeSpeed * delta

		
	if Input.is_action_pressed("swim_right") == false and Input.is_action_pressed("swim_left") == false:
		if velocity.x > 0:
			velocity.x -= deceleration* delta
		elif velocity.x < 0:
			velocity.x += deceleration * delta
	if Input.is_action_pressed("swim_up") == false and Input.is_action_pressed("swim_down") == false:
		if velocity.y > 0:
			velocity.y -= deceleration * delta
		elif velocity.y < 0:
			velocity.y += deceleration * delta
		
	velocity = move_and_slide(velocity)
	
	return velocity

