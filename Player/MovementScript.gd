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
var canDoubleJump : bool = false
var isOnWall : bool = false




# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Melee").disabled = true
	
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
				if Input.is_action_pressed("move_right") and abs(velocity.x) <= speed:
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
			if canDoubleJump == false and isJumping == false:
				isJumping = true
				if is_on_wall():
					print ('23')
					velocity.x += jumpSpeed
				velocity.y += jumpSpeed
			elif canDoubleJump and jumpsRemaining > 0:
				velocity.y += jumpSpeed
				jumpsRemaining -= 1
			
func _process(delta):
	if health <= 0:
		isDead = true
		
func _physics_process(delta):
	#print (velocity.y)
	if is_on_floor() == false and is_on_wall() == false:
		velocity.y += gravity * delta
	else:
		velocity.y = 0
	get_input()
	if isSliding:
		if velocity.x > 0 and is_on_floor():
			velocity.x -= 400 * delta
		elif velocity.x < 0 and is_on_floor():
			velocity.x += 400 * delta
	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN * 4, Vector2.UP)
	if is_on_floor():
		jumpsRemaining = 2
		isJumping = false
	elif is_on_wall():
		isOnWall = true
		isJumping = false
	
