extends Enemy
export var ghostDmg = 1

onready var enemyHealthBar = $EnemyHealthBar;
onready var player = get_tree().get_nodes_in_group("Player")[0]

func _ready():
	self.setMaxHp(1)
	self.gravity = 0

func _physics_process(delta):
	var xDist = player.position.x - self.global_position.x
	var yDist = player.position.y - self.global_position.y
	#print(yDist, "a", xDist) 
	if abs(xDist)<200 and  abs(yDist)< 200:
		velocity.y = yDist
		velocity.x = xDist
	else:
		velocity.x = 0
		velocity.y = 0
	

func _on_playerKiller_body_entered(body):
	if body.name == "Player":
		Global.update_life(-ghostDmg)
		player.velocity.y = -500
