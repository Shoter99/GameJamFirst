extends Entity


export var speed : int = 150
export var swimSpeed : int = 75
export var jumpSpeed : int = -300
#export var gravity : int = 400
export var slideSpeed : int = 300
export var health : int = 10
var jumpsRemaining : int = 2
var isSliding : bool = false
var isJumping : bool = false
var isDead : bool = false
var isInWater = false
var canSwim = false
#var velocity = Vector2()
var canDoubleJump : bool = false




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func get_input():
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
		if isSliding == false:
			velocity.x = 0
			if Input.is_action_pressed("move_right") and abs(velocity.x) <= speed:
				velocity.x = speed
			if Input.is_action_pressed("move_left"):
				velocity.x = -speed
		if Input.is_action_pressed("Slide") and is_on_floor() and isSliding == false:
			print ('debug')
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
				velocity.y += jumpSpeed
			elif canDoubleJump and jumpsRemaining > 0:
				velocity.y += jumpSpeed
				jumpsRemaining -= 1
			
		
		


func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	if isSliding:
		if velocity.x > 0 and is_on_floor():
			velocity.x -= 300 * delta
		elif velocity.x < 0 and is_on_floor():
			velocity.x += 300 * delta
	if is_on_floor():
		jumpsRemaining = 2
		isJumping = false
	velocity = move_and_slide(velocity, Vector2(-1, 0))
	print (isSliding)
	
