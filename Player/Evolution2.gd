extends Evolution1

class_name Evolution2

func _ready():
	jumpsRemaining = 2

func change_jumps(isOnFloor, isOnWall):
	if isOnFloor or isOnWall:
		jumpsRemaining = 2
	if (Input.is_action_just_pressed("jump") and jumpsRemaining > 0) or (isOnWall and Input.is_action_just_pressed("release")):
		 jumpsRemaining -= 1 
	return jumpsRemaining
