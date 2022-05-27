extends KinematicBody2D


export var speed : int = 150
export var jumpSpeed : int = -300
export var gravity : int = 400
var isSliding : bool = false
var isJumping : bool = false
var velocity = Vector2()




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func get_input():
	if isSliding == false:
		velocity.x = 0
		if Input.is_action_pressed("move_right") and abs(velocity.x) <= speed:
			velocity.x = speed
		if Input.is_action_pressed("move_left"):
			velocity.x = -speed
	if Input.is_action_just_pressed("Slide") and is_on_floor() and isSliding == false:
		print ('debug')
		if velocity.x == speed:
			isSliding = true
			velocity.x = 450
		if velocity.x == -speed:
			isSliding = true
			velocity.x = - 450
	if Input.is_action_just_released("Slide"):
		print ('debug')
		isSliding = false
		
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jumpSpeed
		
		


func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	if isSliding:
		if velocity.x > 0:
			velocity.x -= 300 * delta
		elif velocity.x < 0:
			velocity.x += 300 * delta
	if isJumping and is_on_floor():
		isJumping = false
	velocity = move_and_slide(velocity, Vector2(0, -1))
	print (isSliding)
	
