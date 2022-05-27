extends Enemy

export var slimeDmg: = 1

#self.maxEnemyHealth = 2

func _ready():
	velocity.x = 32
	self.enemyHealth = self.maxEnemyHealth


func _physics_process(delta):
	if is_on_wall():
		velocity.x = -velocity.x

func _on_playerDetector_body_entered(body):
	self.hurt_and_die(1)
	
func _on_playerKiller_body_entered(body):
	Global.life = Global.life - slimeDmg
