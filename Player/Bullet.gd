extends KinematicBody2D


export var speed : int = 250
var velocity : Vector2 = Vector2()


func _physics_process(delta : float):
	velocity = Vector2(speed, 0)
	var collision = move_and_collide(velocity * delta)

func _on_Area2D_body_entered(body):
	if(body.is_in_group("Enemy")):
		body.hurt_and_die(1)
	queue_free()
