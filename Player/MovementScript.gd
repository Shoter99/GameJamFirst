extends KinematicBody2D

class_name Player
export var speed : int = 150
export var jumpSpeed : int = -300
export var gravity : int = 400
	
func jump(snapVector, velocity):
	snapVector = Vector2(0, 0)
	velocity.y = jumpSpeed
	return velocity
	
func jump_from_wall(whereWall, velocity):
	if whereWall == "right":
		velocity.x = -speed * 2
	elif whereWall == "left":
		velocity.x = speed * 2
	return velocity
		
func release_from_wall(whereWall, velocity):
	if whereWall == "right":
		velocity.x = -speed
	elif whereWall == "left":
		velocity.x = speed
	return velocity
		
func attack():
	if get_node("Sprite").flip_h:
		get_node("MeleeLeft").disabled = false
		yield(get_tree().create_timer(0.2), "timeout")
		get_node("MeleeLeft").disabled = true
	else:
		get_node("MeleeRight").disabled = false
		yield(get_tree().create_timer(0.2), "timeout")
		get_node("MeleeRight").disabled = true
		
func fire(bullet):
	var bulletInstance = bullet.instance()
	owner.add_child(bulletInstance)
	if get_node("Sprite").flip_h:
		bulletInstance.set_global_position($MeleeLeft.get_global_position())
		bulletInstance.speed = -250	
	else:
		bulletInstance.set_global_position($MeleeRight.get_global_position())
		bulletInstance.get_node("Sprite").set_flip_h(true)
func move_left(delta, velocity):
	get_node("Sprite").set_flip_h(true)
	if velocity.x > -speed:
		if velocity.x < 0:
			velocity.x -= 1000*delta
		else:
			velocity.x -= 2500*delta
		return velocity
func move_right(delta, velocity):
	get_node("Sprite").set_flip_h(false)
	if velocity.x < speed:
		if velocity.x > 0:
			velocity.x += 1000 * delta
		else:
			velocity.x += 2500 * delta
	return velocity
		
func movement(delta, velocity):
	if Input.is_action_pressed("move_right") and velocity.x <= speed:
		move_right(delta, velocity)
	elif Input.is_action_pressed("move_left") and velocity.x >= -speed:
		move_left(delta, velocity)
	elif velocity.x >= -speed/4 and velocity.x <= speed/4:
		velocity.x = 0
