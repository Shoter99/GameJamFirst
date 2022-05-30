extends Player

class_name NoEvolution
var isInAir : bool = false
var isDead : bool = false
var accelerating : bool = false
var velocity: Vector2 = Vector2(0, 0)
var snapVector: Vector2 = Vector2.DOWN * 6
var isOnFloor : bool = false
var inWater : bool = false
var whereWall: = "nothing"
var lastWall: = "nothing"
onready var bullet: = preload("res://Player/Bullet.tscn")

func _ready():
	Global.set_start_options(2,10)
	
		
func evolution0_movement(delta):
		velocity = apply_movement(velocity, isOnFloor, isOnWall, whereWall, bullet, accelerating, delta)
		velocity = move_and_slide_with_snap(velocity, snapVector, Vector2.UP)
		isOnFloor = is_on_floor()
		isOnWall = is_player_on_wall()
	
func _physics_process(delta : float):
	if inWater:
		water_movement(velocity, delta)
	else:
		evolution0_movement(delta)
	
