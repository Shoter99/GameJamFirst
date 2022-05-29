extends Evolution1


class_name Evolution2


func _ready():
	jumpsRemaining = 2



func apply_jump(isOnFloor, isonWall, whereWall, velocity, jumpsRemaining):
	if Input.is_action_just_pressed("jump") and jumpsRemaining > 0:
		velocity = jump(velocity)
		print (jumpsRemaining)
		if isOnWall:
			velocity = jump_from_wall(whereWall, velocity)
			
	if isOnWall and Input.is_action_just_pressed("release"):
		velocity = release_from_wall(whereWall, velocity)
		
	return velocity
	
func change_jumps(jumpsRemaining, isOnFloor, isOnWall):
	if isOnFloor or isOnWall:
		jumpsRemaining = 2
		
	if (Input.is_action_just_pressed("jump") and jumpsRemaining > 0) or (isOnWall and Input.is_action_just_pressed("release")):
		 jumpsRemaining -= 1 
	
	return jumpsRemaining

func _physics_process(delta : float):
	yield(get_tree().create_timer(delta), "timeout")
	jumpsRemaining = change_jumps(jumpsRemaining, isOnFloor, isOnWall)
	

