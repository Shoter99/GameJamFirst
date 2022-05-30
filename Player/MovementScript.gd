extends KinematicBody2D

class_name Player
export var speed : int = 150
export var gravity : int = 400
var jumpsRemaining : int = 2
var isOnWall : bool = false

func _ready():
	get_node("MeleeLeft").disabled = true
	get_node("MeleeRight").disabled = true

func water_movement(velocity, delta):
	gravity = 200
	velocity = apply_gravity(velocity, isOnWall, delta)
	gravity = 400
	return velocity

func is_player_on_wall():
	if is_on_floor():
		return false
	elif is_on_wall():
		return true
	else:
		$Sprite.play("jump")
		return false

func play_animations(velocity) -> void:
	if is_on_floor() and is_on_wall() == false:
		if velocity.x != 0 and is_on_floor():
			$Sprite.play("walk")
		elif velocity.x == 0 and is_on_floor():
			$Sprite.play("idle")

func apply_gravity(velocity, _isOnWall, delta) -> Vector2:
	return Vector2(velocity.x, velocity.y + gravity * delta)

func friction(velocity, accelerating, isOnFloor, delta) -> Vector2:
	if accelerating == false:
		if isOnFloor == false:
			if velocity.x > 0:
				return Vector2(velocity.x - 400 * delta, velocity.y)
			elif velocity.x < 0:
				return Vector2 (velocity.x + 400 * delta, velocity.y)
		else:
			if velocity.x > 0:
				return Vector2 (velocity.x - 600 * delta, velocity.y)
			elif velocity.x < 0:
				return Vector2 (velocity.x + 600 * delta, velocity.y)
	return velocity
		
func move_left(delta, velocity) -> Vector2:
	get_node("Sprite").set_flip_h(true)
	if velocity.x > -speed:
		if velocity.x < 0:
			return Vector2 (velocity.x - 1000 * delta, velocity.y)
		else:
			return Vector2 (velocity.x - 2500 * delta, velocity.y)
	return velocity
	
func move_right(delta, velocity) -> Vector2:
	get_node("Sprite").set_flip_h(false)
	if velocity.x < speed:
		if velocity.x > 0:
			return Vector2 (velocity.x + 1000 * delta, velocity.y)
		else:
			return Vector2 (velocity.x + 2500 * delta, velocity.y)
	return velocity
		
func movement(delta, velocity, _isOnWall) -> Vector2:
	if Input.is_action_pressed("move_right") and velocity.x <= speed:
		return move_right(delta, velocity)
	elif Input.is_action_pressed("move_left") and velocity.x >= -speed:
		return move_left(delta, velocity)
	elif velocity.x >= -speed/4 and velocity.x <= speed/4:
		return Vector2 (0, velocity.y)
	return velocity

func checkAcceleration(velocity) -> bool:
	if is_on_wall() == false:
		if Input.is_action_pressed("move_right") and velocity.x <= speed:
			return true
		elif Input.is_action_pressed("move_left") and velocity.x >= -speed:
			return true
	return false
	
func get_input(velocity, isOnFloor, isOnWall, _whereWall, _bullet, _jumpsRemaining, delta) -> Vector2:
	play_animations(velocity)
	if isOnFloor == false:
		velocity = apply_gravity(velocity, isOnWall, delta)
	velocity = movement(delta, velocity, isOnWall)
	return velocity
		
func apply_movement(velocity, isOnFloor, isOnWall, whereWall, bullet,  accelerating, delta) -> Vector2:
	velocity = get_input(velocity, isOnFloor, isOnWall, whereWall, bullet, jumpsRemaining, delta)
	accelerating = checkAcceleration(velocity)
	velocity = friction(velocity, accelerating, isOnFloor, delta)
	return(velocity)
	
