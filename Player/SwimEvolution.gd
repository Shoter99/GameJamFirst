extends JumpEvolution

class_name SwimEvolution

var swimSpeed : int = 5000

func _ready():
	Global.set_start_options(4, 20)
	
func water_movement(velocity, delta) -> Vector2:
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

