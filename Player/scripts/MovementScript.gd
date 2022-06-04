extends KinematicBody2D


class_name Player, "res://Sprites/player.png"
export var speed : float = 150
export var gravity : float = 400
var jumpsRemaining : int = 2
var isOnWall : bool = false
var floorFriction : float = 600
var airResistance : float = 60
var isGliding : bool = false
var lastWall : = "nothing"

func _ready():
	#get_node("WallDetector").set_deffered("disabled", true)
	#get_node("MeleeLeft").disabled = true
	#get_node("MeleeRight").disabled = true
	pass

func water_movement(_velocity, _delta) -> Vector2:
	Global.life = 0
	return move_and_slide(Vector2.ZERO)

func is_player_on_wall(_isGliding) -> bool:
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

func apply_gravity(velocity, _isOnWall, _isOnFloor, _isGliding, delta) -> Vector2:
	return Vector2(velocity.x, velocity.y + gravity * delta)

func friction(velocity, accelerating, isOnFloor, _isGliding, delta) -> Vector2:
	if accelerating == false:
		if isOnFloor == false:
			if velocity.x > 0:
				if velocity.x - airResistance * delta >= 0:
					return Vector2(velocity.x - airResistance * delta, velocity.y)
				else:
					return Vector2(0, velocity.y)
			elif velocity.x < 0:
				if velocity.x + airResistance * delta <= 0:
					return Vector2 (velocity.x + airResistance * delta, velocity.y)
				else:
					return Vector2 (0, velocity.y)
		else:
			if velocity.x > 0:
				if velocity.x - floorFriction * delta >= 0:
					return Vector2(velocity.x - floorFriction * delta, velocity.y)
				else:
					return Vector2(0, velocity.y)
			elif velocity.x < 0:
				if velocity.x + floorFriction * delta <= 0:
					return Vector2 (velocity.x + floorFriction * delta, velocity.y)
				else:
					return Vector2 (0, velocity.y)
	return velocity

func move_left(delta, velocity) -> Vector2:
	get_node("Sprite").set_flip_h(true)
	get_node("Collision").scale.x = -1
	if velocity.x > -speed:
		if velocity.x < 0:
			if velocity.x - 1000 * delta >= -speed:
				return Vector2 (velocity.x - 1000 * delta, velocity.y)
			else:
				return Vector2 (-speed, velocity.y)
		else:
			return Vector2 (velocity.x - 2500 * delta, velocity.y)
	return velocity

func move_right(delta, velocity) -> Vector2:
	get_node("Sprite").set_flip_h(false)
	get_node("Collision").scale.x = 1
	if velocity.x < speed:
		if velocity.x > 0:
			if velocity.x + 1000 * delta <= speed:
				return Vector2 (velocity.x + 1000 * delta, velocity.y)
			else:
				return Vector2 (speed, velocity.y)
		else:
			return Vector2 (velocity.x + 2500 * delta, velocity.y)
	return velocity

func movement(delta, velocity, _isOnWall) -> Vector2:
	if Input.is_action_pressed("move_right") and velocity.x <= speed and is_on_wall() == false:
		return move_right(delta, velocity)
	elif Input.is_action_pressed("move_left") and velocity.x >= -speed and is_on_wall() == false:
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

func get_input(velocity, isOnFloor, _whereWall, _bullet, _jumpsRemaining, delta) -> Vector2:
	play_animations(velocity)
	velocity = apply_gravity(velocity, isOnWall, isOnFloor, isGliding, delta)
	velocity = movement(delta, velocity, isOnWall)
	return velocity

func apply_movement(velocity, isOnFloor, whereWall, bullet,  accelerating, delta) -> Vector2:
	velocity = get_input(velocity, isOnFloor, whereWall, bullet, jumpsRemaining, delta)
	accelerating = checkAcceleration(velocity)
	velocity = friction(velocity, accelerating, isOnFloor, isGliding, delta)
	return(velocity)

