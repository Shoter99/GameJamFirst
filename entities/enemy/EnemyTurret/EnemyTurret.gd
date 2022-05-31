extends Enemy
export var direction = -1
export var firingSpeed = 1.0

var tillNextShot = firingSpeed
var bullet = preload("res://entities/enemy/EnemyTurret/EnemyBullet.tscn")
onready var player = get_tree().get_nodes_in_group("Player")[0]

func _ready():
	self.setMaxHp(1)
	if direction == 1:
		self.scale = Vector2(-1,1)
	#self.gravity = 0
	pass

func _physics_process(delta):
	tillNextShot -=delta
	if tillNextShot <= 0:
		fire()
		tillNextShot = 1

func fire():
	#print("Firing")
	var bulletFired = bullet.instance()
	bulletFired.global_position.x = self.global_position.x
	bulletFired.global_position.y = self.global_position.y-8
	get_tree().root.add_child(bulletFired)
	if direction == -1:
		bulletFired.flip()
	
func _on_EnemyTurretArea2D_body_entered(body):
	#print(body.name)
	if body.is_in_group("Player"):
		player.get_child(0).knock_up(player.get_child(0).global_position.x - self.global_position.x)
		self.hurt_and_die(1)
