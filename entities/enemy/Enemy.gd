extends Entity

func _ready():
	velocity.x = 32
	

func _physics_process(delta):
	if is_on_wall():
		velocity.x = -velocity.x
	


func _on_detectstomp_body_entered(body:PhysicsBody2D):
	if body.global_position.y > get_node("detectstomp").global_position.y:
		return
	get_node("CollisionShape2D").disabled = true
	queue_free()
		
	
