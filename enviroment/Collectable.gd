extends Area2D

var CollectedEffect := preload("res://enviroment/CollectableEffect.tscn")

func _on_Collectable_body_entered(body):
	Global.collected += 1
	var effect := CollectedEffect.instance()
	effect.global_position = global_position
	get_tree().current_scene.add_child(effect)
	print(Global.collected)
	queue_free()