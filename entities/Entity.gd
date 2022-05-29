extends KinematicBody2D

class_name Entity
export var gravity = 256
export var velocity: = Vector2(0.0,0.0)
func _physics_process(delta):
	
	move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
	if abs(velocity.x)>512:
		velocity.x = 512*sign(velocity.x)
	if is_on_floor():
		velocity.y = 0
	else:
		velocity.y +=gravity*delta
