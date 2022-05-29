extends Enemy


export var slimeDmg: = 1
onready var enemyHealthBar = $EnemyHealthBar;
onready var player = get_tree().get_nodes_in_group("Player")[0]
export var enemySpeed := 32
var goingRight := 1

#self.maxEnemyHealth = 2

func _ready():
	velocity.x = 32
	self.setMaxHp(3)
	#self.enemyHealth = self.maxEnemyHealth


func _physics_process(delta):
	if is_on_wall():
		bounce()
	
	#var vel := Vector2(enemySpeed * delta * goingRight, 0)
	#move_and_collide(vel)

func _on_playerDetector_body_entered(body):
	if body.name == "Player":
		player.velocity.y = -150
		self.hurt_and_die(1)
		bounce()
	if body.name == "Bullet":
		self.hurt_and_die(1)
		self.velocity.y -= 75
		
func _on_playerKiller_body_entered(body):
	if body.name == "Player":
		Global.update_life(-slimeDmg)
		#print(Global.life)
		player.velocity.y = -500
		
func bounce():
	goingRight = goingRight * -1
	velocity.x = -velocity.x
	get_node("Enemy").set_flip_h(true if goingRight != 1 else false)

func _on_BounceDetectorArea_body_entered(body):
	bounce()
