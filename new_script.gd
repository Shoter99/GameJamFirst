extends Player

var isInAir : bool = false
var isDead : bool = false
var accelerating : bool = false
var velocity: Vector2 = Vector2()
var snapVector: Vector2 = Vector2.DOWN * 6
var isOnWall : bool = false
var whereWall: = "nothing"
var lastWall: = "nothing"
onready var bullet: = preload("res://Player/Bullet.tscn")

func get_input(delta):
	if Input.is_action_just_pressed("attack") and is_on_floor() and is_on_wall() == false:
		attack()
	if Input.is_action_just_pressed("fire"):
		fire(bullet)
	if is_on_wall() == false:
		if Input.is_action_pressed("move_right") and velocity.x <= speed:
			velocity = move_right(delta, velocity)
			accelerating = true
		elif Input.is_action_pressed("move_left") and velocity.x >= -speed:
			velocity = move_left(delta, velocity)
			accelerating = true
		elif velocity.x >= -speed/4 and velocity.x <= speed/4:
			velocity.x = 0
			accelerating = false
			
	if Input.is_action_just_pressed("jump") and (is_on_floor() or is_on_wall()):
		snapVector = Vector2 (0,0)
		velocity = jump(snapVector, velocity)
		if isOnWall:
			velocity = jump_from_wall(whereWall, velocity)
			
	if isOnWall and Input.is_action_just_pressed("release"):
		velocity = release_from_wall(whereWall, velocity)
		
func _ready():
	get_node("MeleeLeft").disabled = true
	get_node("MeleeRight").disabled = true
	Global.update_life(Global.max_life)
	
func _process(delta): 
	if is_on_floor() and is_on_wall() == false:
		if velocity.x != 0 and is_on_floor():
			$Sprite.play("walk")
		elif velocity.x == 0 and is_on_floor():
			$Sprite.play("idle")
	if isOnWall:
		velocity.y = 0
		velocity.x = 0
	else:
		velocity.y += gravity * delta
	accelerating = false
	get_input(delta)
	if is_on_floor() == false and accelerating == false:
		if velocity.x > 0:
			velocity.x -= 400 * delta
		elif velocity.x < 0:
			velocity.x += 400 * delta
	elif accelerating == false:
		if is_on_floor():
			if velocity.x > 0:
				velocity.x -= 600 * delta
			elif velocity.x < 0:
				velocity.x += 600 * delta
	velocity = move_and_slide_with_snap(velocity, snapVector, Vector2.UP)
	snapVector = Vector2.DOWN * 6
	if is_on_floor():
		lastWall = "nothing"
		whereWall = "nothing"
		isInAir = false
		isOnWall = false
	elif is_on_wall():
		isInAir = false
		isOnWall = true
		for i in range (get_slide_count()):
			if get_slide_collision(i):
				if get_slide_collision(i).position.x > get_position().x:
					whereWall = "right"
					$Sprite.play("on_wall")
					get_node("Sprite").set_flip_h(true)
				else:
					whereWall = "left"
					$Sprite.play("on_wall")
					get_node("Sprite").set_flip_h(false)
				
	else:
		whereWall = "nothing"
		$Sprite.play("jump")
		isInAir = true
		isOnWall = false
	print (velocity)
