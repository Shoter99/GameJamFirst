extends KinematicBody2D

onready var velocity = Vector2(-64,0)
func _ready():
	pass
	
func	_physics_process(delta):
	move_and_slide(velocity)
	
func flip():
	self.get_node("AnimatedSprite").flip_h(true)


