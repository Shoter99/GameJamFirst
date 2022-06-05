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
var maxSlides : int = 4
var canSwim = false
var wasInWater = false
onready var bullet: = preload("res://Player/Bullet.tscn")

func _ready() -> void:
	Global.set_start_options(2,10)
	
func change_jumps(_jumpsRemaining, _isOnFloor, _isOnWall) -> int:
	return 2

func evolution0_movement(delta) -> void:
	velocity = apply_movement(velocity, isOnFloor, whereWall, bullet, accelerating, delta)
	velocity = move_and_slide_with_snap(velocity, snapVector, Vector2.UP, true, maxSlides)
	isOnFloor = is_on_floor()
	isOnWall = is_player_on_wall(isGliding)

func knock_up(directon) -> void:
	velocity.y = -150
	velocity.x = 150 * sign(directon)
	var tmp = snapVector
	snapVector = Vector2.ZERO
	velocity = move_and_slide_with_snap(velocity, snapVector, Vector2.UP)
	snapVector = tmp
	$Sprite.play("idle")
	$Sprite.play("jump")

func _physics_process(delta : float) ->void:
	
		
	if inWater:
		if not canSwim:
			Global.update_life(-2)
			self.knock_up(0)
		elif not wasInWater:
			$Sprite.play("swim")
			$Collision.disabled = true
			$SwimmingColision.disabled = false
		wasInWater = true
		velocity = water_movement(velocity, delta)
	else:
		
		if wasInWater == true:
			#print("toggled")
			$Collision.disabled = false
			$SwimmingColision.disabled = true
		wasInWater = false
		evolution0_movement(delta)
		jumpsRemaining = change_jumps(jumpsRemaining, isOnFloor, isOnWall)
