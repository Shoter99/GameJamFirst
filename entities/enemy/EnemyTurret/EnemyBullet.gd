extends KinematicBody2D
export var bulletDmg = 1


onready var player = get_tree().get_nodes_in_group("Player")[0]
export onready var velocity = Vector2(-128,0)

func _ready():
	pass
	
func	_physics_process(delta):
	move_and_slide(velocity)
	
func flip():
	self.scale = Vector2(-1,1)
	self.velocity *=-1
	
func set_velocity(x):
	#print(velocity)
	velocity = x

func _on_Area2D_body_entered(body):
	#print(body.name)
	if body.is_in_group("Player"):
		Global.update_life(-bulletDmg)
		player.get_child(0).knock_up(player.get_child(0).global_position.x - self.global_position.x)
	queue_free()
