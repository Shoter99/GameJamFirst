extends Enemy
export var ghostDmg = 1
onready var isFlipped = false
onready var enemyHealthBar = $EnemyHealthBar;
onready var player = get_tree().get_nodes_in_group("Player")[0]

func _ready():
	walking = false
	self.setMaxHp(1)
	self.gravity = 0
	

func _physics_process(delta):
	var xDist = player.get_child(0).global_position.x - self.global_position.x
	var yDist = player.get_child(0).global_position.y - self.global_position.y
	
	if xDist<0 != isFlipped:
		isFlipped = not isFlipped
		get_node("AnimatedGhost").set_flip_h(isFlipped)
	
	#print(self.global_position.x, "a", player.get_child(0).global_position.x, "a", xDist) 
	if abs(xDist)<200 and  abs(yDist)< 200:
		velocity.y = yDist*2
		velocity.x = xDist*2
#		print(velocity.x, velocity.y)
	move_and_slide(velocity)
	

func _on_playerKiller_body_entered(body):
	if body.is_in_group("Player"):
		Global.update_life(-ghostDmg)
		player.get_child(0).knock_up( player.get_child(0).global_position.x - self.global_position.x)
