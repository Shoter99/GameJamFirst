extends Enemy
export var firingSpeed = 2.0
var tillNextShot = firingSpeed
var bullet = preload("res://entities/enemy/EnemyTurret/EnemyBullet.tscn")
onready var player = get_tree().get_nodes_in_group("Player")[0]
export var diagonalBulletVelocity = 64

func _ready():
	self.setMaxHp(1)
	self.gravity = 0
	#self.gravity = 0
	pass
	
func rotation_to_player():
	var x = player.get_child(0).position.x - self.position.x
	var y = self.position.y - player.get_child(0).position.y
	var deviation = atan(y/x)
	#print(deviation)
	return deviation
	
func set_animation():
	var x = sign(player.get_child(0).position.x - self.position.x)
	var d = rotation_to_player() * 60 * x
	if x <0:
		get_node("RotatingPeeper").set_flip_h(true)
	else:
		get_node("RotatingPeeper").set_flip_h(false)
	#print(d/PI)
	if d>58: $RotatingPeeper.play("up")
	elif d>40: $RotatingPeeper.play("up r")
	elif d>20: $RotatingPeeper.play("right u")
	elif d>-20: $RotatingPeeper.play("right")
	elif d>-40: $RotatingPeeper.play("right d")
	elif d>-58: $RotatingPeeper.play("down r")
	else: $RotatingPeeper.play("down")
		
func _process(_delta):
	set_animation()
	
func _physics_process(delta):
	tillNextShot -=delta
	if tillNextShot <= 0:
		fire()
		tillNextShot = firingSpeed

func fire():
	#print("Firing")
	var bulletFired = bullet.instance()
	bulletFired.position.x = self.position.x
	bulletFired.position.y = self.position.y-8
	var x = player.get_child(0).position.x - self.position.x
	var y = self.position.y - player.get_child(0).position.y
	bulletFired.global_rotation = -atan2(y,x)
	var vscale = diagonalBulletVelocity/sqrt(x*x+y*y)
	#bulletFired.velocity = Vector2(x*vscale, y*vscale)
	
	get_tree().root.add_child(bulletFired)
	bulletFired.set_velocity(Vector2(x*vscale, -y*vscale))
	bulletFired.scale = Vector2(-1,-1)
	
	
func _on_EnemyTurretArea2D_body_entered(body):
	#print(body.name)
	if body.is_in_group("Player"):
		player.get_child(0).knock_up(player.get_child(0).position.x - self.position.x)
		self.hurt_and_die(1)
