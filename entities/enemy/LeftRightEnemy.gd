extends Enemy


export var slimeDmg: = 1
onready var enemyHealthBar = $EnemyHealthBar;
export var enemySpeed := 32
var goingRight := 1

#self.maxEnemyHealth = 2

#func _ready():
#
	#self.enemyHealth = self.maxEnemyHealth


func _physics_process(delta):
	if is_on_wall():
		goingRight = goingRight * -1
		get_node("Enemy").set_flip_h(true if goingRight != 1 else false)
	var vel := Vector2(enemySpeed * delta * goingRight, 0)
	move_and_collide(vel)

func _on_playerDetector_body_entered(body):
	self.hurt_and_die(1)
	
	
func _on_playerKiller_body_entered(body):
	if body.name == "KinematicBody2D":
		Global.update_life(-slimeDmg)
		print(Global.life)
	
