extends Entity

class_name Enemy

signal enemy_health_changed(new_hp)

export var enemyMaxHp: = 1
export var enemyHp: = 1


onready var death_particles := preload("res://enviroment/Particles/Enemy/EnemyParticles.tscn")

#func _physics_process(delta):
#	if is_on_wall():
#		velocity.x = -velocity.x
	
func hurt_and_die(x):
	self.enemyHp = self.enemyHp - x
	emit_signal("enemy_health_changed", self.enemyHp)
	if self.enemyHp == 0:
		
		Global.update_collectable(1*(Global.currentLevel+1))
		var effect := death_particles.instance()
		effect.position = position
		get_tree().current_scene.add_child(effect)
		queue_free()

func get_current_hp():
	return self.enemyHp

func setMaxHp(x):
	enemyMaxHp = x
	enemyHp = enemyMaxHp
