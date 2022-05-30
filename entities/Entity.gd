extends KinematicBody2D

class_name Entity
export var gravity = 256
export var velocity: = Vector2(0.0,0.0)
export var walking = true
func _physics_process(delta):
	
	if walking:
		move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
	if abs(velocity.x)>512:
		velocity.x = 512*sign(velocity.x)
	if is_on_floor():
		velocity.y = min(0,velocity.y)
	else:
		velocity.y +=gravity*delta
