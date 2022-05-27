extends KinematicBody2D

class_name Player
export var speed : int = 150
export var swimSpeed : int = 75
export var jumpSpeed : int = -300
export var gravity : int = 400
export var slideSpeed : int = 320
export var health : int = 10
var jumpsRemaining : int = 2
var isSliding : bool = false
var isJumping : bool = false
var isDead : bool = false
var isInWater = false
var canSwim = false
var velocity = Vector2()
var snapVector = Vector2.DOWN * 4
var isOnWall : bool = false
var isGliding : bool = false
var whereWall: = "right"



func _ready():
	get_node("Melee").disabled = true
	
func jump():
	snapVector = Vector2(0, 0)
	isJumping = true
	velocity.y = jumpSpeed
	
func get_input():
	if Input.is_action_just_pressed("attack"):
		get_node("Melee").disabled = false
		yield(get_tree().create_timer(0.2), "timeout")
		get_node("Melee").disabled = true
		
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
				velocity.x = 0
				if Input.is_action_pressed("move_right"):
					velocity.x = speed
				if Input.is_action_pressed("move_left"):
					velocity.x = -speed
			if Input.is_action_pressed("Slide") and is_on_floor() and isSliding == false:
				if velocity.x == speed:
					isSliding = true
					velocity.x = slideSpeed
				if velocity.x == -speed:
					isSliding = true
					velocity.x = - slideSpeed
			if Input.is_action_just_released("Slide"):
				isSliding = false

			
			
		if Input.is_action_just_pressed("jump"):
			if jumpsRemaining > 0:
				jump()
				jumpsRemaining -= 1
			if is_on_wall() and is_on_floor() == false:
				if whereWall == "right":
					velocity.x = jumpSpeed
				elif whereWall == "left":
					velocity.x = -jumpSpeed
				velocity.y = jumpSpeed
				isJumping = true
				jumpsRemaining = 2
			
func _process(delta: float):
	if health <= 0:
		isDead = true
		
func _physics_process(delta : float):
	
	if is_on_floor() == false and is_on_wall():		


		velocity.y = 0
		velocity.x = 0
	else:
		if isGliding:
			velocity.y = 75
		else:
			velocity.y += gravity * delta
	get_input()
	var collision = get_slide_collision(1)
	if isSliding:
		if velocity.x > 0 and is_on_floor():
			velocity.x -= 400 * delta
		elif velocity.x < 0 and is_on_floor():
			velocity.x += 400 * delta
	velocity = move_and_slide_with_snap(velocity, snapVector, Vector2.UP)
	snapVector = Vector2.DOWN * 4
	if is_on_floor():
		jumpsRemaining = 2
		isJumping = false
		whereWall = "nothing"
	elif is_on_wall():
		isOnWall = true
		isJumping = false
		if collision:
			if collision.position.x > get_position().x:
				whereWall = "right"
			else:
				whereWall = "left"
	print (whereWall)

		
