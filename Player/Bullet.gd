extends KinematicBody2D


export var speed : int = 250
var velocity : Vector2 = Vector2()


func _physics_process(delta : float):
	velocity = Vector2(speed, 0)
	var collision = move_and_collide(velocity * delta)
	if collision:
		self.queue_free()
