extends Control

export var enemy_max_hp :=3

func _ready():
	$TextureProgress.max_value = enemy_max_hp
	$TextureProgress.value = enemy_max_hp


func _on_LeftRightEnemySlime_enemy_health_changed(new_hp):
	$TextureProgress.value = new_hp
