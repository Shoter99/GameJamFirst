extends KinematicBody2D


export var speed : int = 300
export var jumpSpeed : int = -300
export var gravity : int = 400
var isJumping : bool = false
var velocity = Vector2()




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func get_input():
	velocity.x = 0
	if Input.is_action_pressed("move_right"):
		velocity.x += speed
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = jumpSpeed


func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	if isJumping and is_on_floor():
		isJumping = false
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
