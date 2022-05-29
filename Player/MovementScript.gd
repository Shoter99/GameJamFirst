extends KinematicBody2D

class_name Player
export var speed : int = 150
export var swimSpeed : int = 75
export var jumpSpeed : int = -300
export var gravity : int = 400
export var slideSpeed : int = 320
var jumpsRemaining : int = 2
var isSliding : bool = false
var isInAir : bool = false
var isDead : bool = false
var isInWater : bool = false
var accelerating : bool = false
var canSwim: bool = false
var velocity: Vector2 = Vector2()
var snapVector: Vector2 = Vector2.DOWN * 6
var isOnWall : bool = false
var isGliding : bool = false
var whereWall: = "nothing"
var lastWall: = "nothing"
onready var bullet: = preload("res://Player/Bullet.tscn")

func _ready() -> void:
	get_node("MeleeLeft").disabled = true
	get_node("MeleeRight").disabled = true
	Global.update_life(Global.max_life)
	
func jump() -> void:
	snapVector = Vector2(0, 0)
	velocity.y = jumpSpeed
	
func get_input(delta : float) -> void:
	if Input.is_action_just_pressed("attack") and is_on_floor() and is_on_wall() == false:
		if get_node("Sprite").flip_h:
			get_node("MeleeLeft").disabled = false
			yield(get_tree().create_timer(0.2), "timeout")
			get_node("MeleeLeft").disabled = true
		else:
			get_node("MeleeRight").disabled = false
			yield(get_tree().create_timer(0.2), "timeout")
			get_node("MeleeRight").disabled = true
	if Input.is_action_just_pressed("fire"):
		var bulletInstance : = bullet.instance()
		owner.add_child(bulletInstance)
		if get_node("Sprite").flip_h:
			bulletInstance.set_global_position($MeleeLeft.get_global_position())
			bulletInstance.speed = -250
			
		else:
			bulletInstance.set_global_position($MeleeRight.get_global_position())
			bulletInstance.get_node("Sprite").set_flip_h(true)
		
		
	if isInWater:
		if Input.is_action_pressed("swim_right"):
			velocity.x = swimSpeed
		if Input.is_action_pressed("swim_left"):
			velocity.x = -swimSpeed
		if Input.is_action_pressed("swim_up"):
			velocity.y = -swimSpeed
		if Input.is_action_pressed("swim_down"):
			velocity.y = swimSpeed
		
	else:
		if is_on_wall() == false:
			if isSliding == false:
				if Input.is_action_pressed("move_right") and velocity.x <= speed:
					get_node("Sprite").set_flip_h(false)
					if velocity.x < speed:
						if velocity.x > 0:
							velocity.x += 1000 * delta
						else:
							velocity.x += 2500 * delta
						#velocity.x = speed
						accelerating = true
				elif Input.is_action_pressed("move_left") and velocity.x >= -speed:
					get_node("Sprite").set_flip_h(true)
					if velocity.x > -speed:
						if velocity.x < 0:
							velocity.x -= 1000*delta
						else:
							velocity.x -= 2500*delta
						#velocity.x = -speed
						accelerating = true
				elif velocity.x >= -speed/4 and velocity.x <= speed/4:
					velocity.x = 0
				else:
					accelerating = false
				if Input.is_action_pressed("Slide") and is_on_floor():
					if velocity.x == speed:
						isSliding = true
						velocity.x = slideSpeed
					if velocity.x == -speed:
						isSliding = true
						velocity.x = - slideSpeed
			elif Input.is_action_just_released("Slide"):
				isSliding = false
			
		if Input.is_action_just_pressed("jump") and isGliding == false:
			if jumpsRemaining > 0:
				jump()
				jumpsRemaining -= 1
			if isOnWall:
				if whereWall == "right":
					velocity.x = -speed * 2
					lastWall = "right"
				elif whereWall == "left":
					velocity.x = speed * 2
					lastWall = "left"

		if Input.is_action_pressed("glide") and is_on_floor() == false and is_on_wall() == false:
			isGliding = true
		else:
			isGliding = false
		
		if isOnWall and Input.is_action_just_pressed("release"):
			if whereWall == "right":
				velocity.x = -speed
			elif whereWall == "left":
				velocity.x = speed
				
			
func _process(delta: float) -> void:
	if Global.life <= 0:
		isDead = true
		
func _physics_process(delta : float) -> void:
	if is_on_floor() and is_on_wall() == false:
		if velocity.x != 0 and is_on_floor():
			$Sprite.play("walk")
		elif velocity.x == 0 and is_on_floor():
			$Sprite.play("idle")
	if isOnWall:
		velocity.y = 0
		velocity.x = 0
	else:
		if isGliding:
			velocity.y = 75
		else:
			velocity.y += gravity * delta
	get_input(delta)
	if (isSliding or is_on_floor() == false) and accelerating == false:
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
		jumpsRemaining = 2
		lastWall = "nothing"
		whereWall = "nothing"
		isInAir = false
		isOnWall = false
	elif is_on_wall():
		jumpsRemaining = 2
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
	#print (velocity.x)
		
