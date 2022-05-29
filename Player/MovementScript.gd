extends KinematicBody2D

class_name Player
export var speed : int = 150
export var jumpSpeed : int = -300
export var gravity : int = 400
var jumpsRemaining : int = 1

func water_movement(velocity, isOnWall, delta):
	gravity = 200
	apply_gravity(velocity, isOnWall, delta)

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
	
func jump(velocity) -> Vector2:
	return Vector2(velocity.x, jumpSpeed)
	
func jump_from_wall(whereWall, velocity):
	if whereWall == "right":
		velocity.x = -speed * .1
	elif whereWall == "left":
		velocity.x = speed * .1
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
		
func fire(bullet) -> void:
	var bulletInstance = bullet.instance()
	owner.add_child(bulletInstance)
	if get_node("Sprite").flip_h:
		bulletInstance.set_global_position($MeleeLeft.get_global_position())
		bulletInstance.speed = -250	
	else:
		bulletInstance.set_global_position($MeleeRight.get_global_position())
		bulletInstance.get_node("Sprite").set_flip_h(true)
		
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

func checkAcceleration(velocity) -> bool:
	if is_on_wall() == false:
		if Input.is_action_pressed("move_right") and velocity.x <= speed:
			return true
		elif Input.is_action_pressed("move_left") and velocity.x >= -speed:
			return true
	return false
	
func is_player_on_wall():
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
				
				
func apply_jump(isOnFloor, isOnWall, whereWall, velocity, jumpsRemaining):
	if Input.is_action_just_pressed("jump") and (isOnFloor or isOnWall):
		velocity = jump(velocity)
		if isOnWall:
			velocity = jump_from_wall(whereWall, velocity)
			
	if isOnWall and Input.is_action_just_pressed("release"):
		velocity = release_from_wall(whereWall, velocity)
	return velocity
	
		
func get_input(velocity, isOnFloor, isOnWall, whereWall, bullet, delta) -> Vector2:
	play_animations(velocity)
	if isOnFloor == false:
		velocity = apply_gravity(velocity, isOnWall, delta)
	if Input.is_action_just_pressed("attack") and is_on_floor() and is_on_wall() == false:
		attack()
	if Input.is_action_just_pressed("fire"):
		fire(bullet)
	if isOnWall == false:
		velocity = movement(delta, velocity)
	
	velocity = apply_jump(isOnFloor, isOnWall, whereWall, velocity, jumpsRemaining)

	return velocity
		
func apply_movement(velocity, isOnFloor, isOnWall, whereWall, bullet, accelerating, snapVector, delta) -> Vector2:
	snapVector = Vector2(0, 0)
	velocity = get_input(velocity, isOnFloor, isOnWall, whereWall, bullet, delta)
	accelerating = checkAcceleration(velocity)
	snapVector = Vector2.DOWN * 6
	velocity = friction(velocity, accelerating, isOnFloor, delta)
	return(velocity)
	
