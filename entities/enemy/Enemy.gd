extends Entity

func _ready():
	velocity.x = 32
	

func _physics_process(delta):
	if is_on_wall():
		velocity.x = -velocity.x
	
