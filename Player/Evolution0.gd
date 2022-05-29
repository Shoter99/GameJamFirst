extends Player

class_name Evolution0

var isInAir : bool = false
var isDead : bool = false
var accelerating : bool = false
var velocity: Vector2 = Vector2(0, 0)
var snapVector: Vector2 = Vector2.DOWN * 8
var isOnWall : bool = false
var isOnFloor : bool = false
var inWater : bool = false
var whereWall: = "nothing"

func evolution0_movement(delta):
		snapVector = disable_snap_vector()
		velocity = apply_movement(velocity, isOnFloor, isOnWall, whereWall, accelerating, delta)
		velocity = move_and_slide_with_snap(velocity, snapVector, Vector2.UP)
		snapVector = Vector2.DOWN * 8
		isOnWall = is_player_on_wall()
		if isOnWall:
			whereWall = check_where_wall()
		isOnFloor = is_on_floor()

func _physics_process(delta : float):
	if inWater:
		velocity = move_and_slide(water_movement(velocity, isOnWall, delta))
	else:
		evolution0_movement(delta)
	yield(get_tree().create_timer(delta), "timeout")
	jumpsRemaining = change_jumps(isOnFloor, isOnWall)
