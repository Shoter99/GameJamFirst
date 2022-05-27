extends Entity

class_name Enemy
export var enemyMaxHp: = 3
export var enemyHp: = 3


func _ready():
	velocity.x = 32
	

func _physics_process(delta):
	if is_on_wall():
		velocity.x = -velocity.x
	
func hurt_and_die(x):
	self.enemyHp = self.enemyHp - 1
	if self.enemyHp == 0:
		queue_free()
