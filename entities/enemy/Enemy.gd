#enemy is bugged

extends Entity

func _ready():
	velocity.x = 32
	

func _physics_process(delta):
	if is_on_wall():
		velocity.x = -velocity.x
	
func _on_playerDetector_body_entered(body):
	return
	if body.global_positon.y > get_node("playerDetector").y:
		return
	queue_free()
