extends KinematicBody2D

class_name Player, "res://Sprites/player.png"
export var speed : float = 150
export var jumpSpeed : int = -300
export var gravity : int = 400
var jumpsRemaining : int = 1

func _ready():
	get_node("MeleeLeft").disabled = true
	get_node("MeleeRight").disabled = true

func water_movement(velocity, isOnWall, delta) -> Vector2:
	gravity = 200
	return apply_gravity(velocity, isOnWall, delta)

func play_animations(velocity) -> void:
	if is_on_floor() and is_on_wall() == false:
		if velocity.x != 0 and is_on_floor():
			$Sprite.play("walk")
		elif velocity.x == 0 and is_on_floor():
			$Sprite.play("idle")

func apply_gravity(velocity, isOnWall, delta) -> Vector2:
	if isOnWall:
		return Vector2 (0, 0)
	else:
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
	
func disable_snap_vector() -> Vector2:
	if Input.is_action_just_pressed("jump"):
		return Vector2 (0, 0)
	return Vector2.DOWN * 6

func change_jumps(isOnFloor, isOnWall):
	if isOnFloor or isOnWall:
		jumpsRemaining = 1
		
	if (Input.is_action_just_pressed("jump") and jumpsRemaining > 0) or (isOnWall and Input.is_action_just_pressed("release")):
		 jumpsRemaining -= 1 
	
	return jumpsRemaining

	
func jump(velocity) -> Vector2:
	return Vector2(velocity.x, jumpSpeed)
	
func jump_from_wall(whereWall, velocity):
	if whereWall == "right":
		velocity.x = -speed * .1
	elif whereWall == "left":
		velocity.x = speed * .1
	return velocity
	
func jump_away_from_wall(whereWall, velocity):
	velocity = jump(velocity*1.2)
	if whereWall == "right":
		velocity.x = -speed * 1
	elif whereWall == "left":
		velocity.x = speed * 1
	return velocity	
		
func release_from_wall(whereWall, velocity) -> Vector2:
	if whereWall == "right":
		return Vector2(-speed*.1, velocity.y)
	elif whereWall == "left":
		return Vector2(speed*.1, velocity.y)
	return velocity
		
func attack() -> void:
	if get_node("Sprite").flip_h:
		get_node("MeleeLeft").disabled = false
		yield(get_tree().create_timer(0.2), "timeout")
		get_node("MeleeLeft").disabled = true
	else:
		get_node("MeleeRight").disabled = false
		yield(get_tree().create_timer(0.2), "timeout")
		get_node("MeleeRight").disabled = true
		
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
		
func movement(delta, velocity) -> Vector2:
	if Input.is_action_pressed("move_right") and velocity.x <= speed:
		return move_right(delta, velocity)
	elif Input.is_action_pressed("move_left") and velocity.x >= -speed:
		return move_left(delta, velocity)
	elif velocity.x >= -speed/4 and velocity.x <= speed/4:
		return Vector2 (0, velocity.y)
	return velocity

func checkAcceleration(isOnWall) -> bool:
	if (Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left")) and isOnWall == false:
		return true
	return false
	
func is_player_on_wall() -> bool:
	if is_on_floor():
		return false
	elif is_on_wall():
		return true
	else:
		$Sprite.play("jump")
		return false
		
func check_where_wall():
	for i in range (get_slide_count()):
		if get_slide_collision(i):
			if get_slide_collision(i).position.x > get_position().x:
				$Sprite.play("on_wall")
				get_node("Sprite").set_flip_h(true)
				return "right"
			else:
				$Sprite.play("on_wall")
				get_node("Sprite").set_flip_h(false)
				return "left"
				
				
func apply_jump(isOnWall, whereWall, velocity):
	if isOnWall:
		if Input.is_action_just_pressed("release"):
			velocity = release_from_wall(whereWall, velocity)
		elif whereWall == "left" and Input.is_action_pressed("move_right") and Input.is_action_just_pressed("jump"):
			return jump_away_from_wall(whereWall, velocity)
		elif whereWall == "right" and Input.is_action_pressed("move_left") and Input.is_action_just_pressed("jump"):
			return jump_away_from_wall(whereWall, velocity)
	
	if Input.is_action_just_pressed("jump") and jumpsRemaining > 0:
		velocity = jump(velocity)
		if isOnWall:
			return jump_from_wall(whereWall, velocity)
			
	return velocity
		
func get_input(velocity, isOnFloor, isOnWall, whereWall, delta) -> Vector2:
	play_animations(velocity)
	if isOnFloor == false:
		velocity = apply_gravity(velocity, isOnWall, delta)
	if Input.is_action_just_pressed("attack") and is_on_floor() and is_on_wall() == false:
		attack()
	if isOnWall == false:
		velocity = movement(delta, velocity)
	
	velocity = apply_jump(isOnWall, whereWall, velocity)

	return velocity
		
func apply_movement(velocity, isOnFloor, isOnWall, whereWall, accelerating, delta) -> Vector2:
	velocity = get_input(velocity, isOnFloor, isOnWall, whereWall, delta)
	accelerating = checkAcceleration(isOnWall)
	velocity = friction(velocity, accelerating, isOnFloor, delta)
	return(velocity)
	
