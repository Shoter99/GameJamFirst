extends Area2D

var CollectedEffect := preload("res://enviroment/Particles/Collectable/CollectableEffect.tscn")


func _on_Collectable_body_entered(body):
	if not body.is_in_group("Player"):
		return
	#emit_signal("collected")
	Global.update_collectable(3*(Global.currentLevel+1))
	var effect := CollectedEffect.instance()
	effect.global_position = global_position
	get_tree().current_scene.add_child(effect)
	#print(Global.collected)
	queue_free()
