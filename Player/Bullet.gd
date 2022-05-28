extends KinematicBody2D


export var speed : int = 200
var velocity : Vector2 = Vector2()



func _ready():
	velocity = Vector2(speed, 0)



func _physics_process(delta : float):
	var collision = move_and_collide(velocity * delta)
	if collision:
		self.queue_free()
