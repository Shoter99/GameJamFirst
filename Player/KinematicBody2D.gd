extends Entity


export var speed : int = 150
export var swimSpeed : int = 75
export var jumpSpeed : int = -300
export var playerGravity : int = 400
export var slideSpeed : int = 320
export var health : int = 10
var jumpsRemaining : int = 2
var isSliding : bool = false
var isJumping : bool = false
var isDead : bool = false
var isInWater = false
var canSwim = false
var playerVelocity = Vector2()
var canDoubleJump : bool = false




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func get_input():
	if isInWater:
		if Input.is_action_pressed("swim_right"):
			playerVelocity.x = swimSpeed
		if Input.is_action_pressed("swim_left"):
			playerVelocity.x = -swimSpeed
		if Input.is_action_pressed("swim_up"):
			playerVelocity.y = -swimSpeed
		if Input.is_action_pressed("swim_down"):
			playerVelocity.y = swimSpeed
		
	else:
		if isSliding == false:
			playerVelocity.x = 0
			if Input.is_action_pressed("move_right") and abs(playerVelocity.x) <= speed:
				playerVelocity.x = speed
			if Input.is_action_pressed("move_left"):
				playerVelocity.x = -speed
		if Input.is_action_pressed("Slide") and is_on_floor() and isSliding == false:
			if playerVelocity.x == speed:
				isSliding = true
				playerVelocity.x = slideSpeed
			if playerVelocity.x == -speed:
				isSliding = true
				playerVelocity.x = - slideSpeed
		if Input.is_action_just_released("Slide"):
			isSliding = false
			
			
		if Input.is_action_just_pressed("jump"):
			if canDoubleJump == false and isJumping == false:
				isJumping = true
				print ('debug')
				playerVelocity.y += jumpSpeed
			elif canDoubleJump and jumpsRemaining > 0:
				playerVelocity.y += jumpSpeed
				jumpsRemaining -= 1
			
		
		


func _physics_process(delta):
	print (playerVelocity.y)
	if is_on_floor() == false:
		playerVelocity.y += playerGravity * delta
	else:
		playerVelocity.y = 0
	get_input()
	if isSliding:
		if playerVelocity.x > 0 and is_on_floor():
			playerVelocity.x -= 350 * delta
		elif playerVelocity.x < 0 and is_on_floor():
			playerVelocity.x += 350 * delta
	playerVelocity = move_and_slide_with_snap(playerVelocity, Vector2.DOWN * 4, Vector2.UP)
	if is_on_floor():
		jumpsRemaining = 2
		isJumping = false
	#print (isSliding)
	#print (is_on_floor())
	
