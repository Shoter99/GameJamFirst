extends Enemy
export var direction = -1
export var firingSpeed = 1.0
var tillNextShot = firingSpeed
var bullet = preload("res://entities/enemy/EnemyTurret/EnemyBullet.tscn")


func _physics_process(delta):
	tillNextShot -=delta
	if tillNextShot <= 0:
		fire()

		tillNextShot = 1

func _ready():
	self.gravity = 0


func fire():
	print("Firing")
	var bulletFired = bullet.instance()
	bulletFired.global_position = self.global_position
	add_child(bulletFired)
	#bulletFired.get_node("Bullet").set_flip_h(true)# *= direction
	
