extends Node


var max_life : int= 3
var life : int = 0
var collected : int = 0

signal life_changed(life)
signal collectable_update(collected)

func update_life(var delta: int):
	life+=delta
	emit_signal("life_changed", life)
	if life <= 0: get_tree().reload_current_scene()

func update_collectable(var delta: int):
	life+=delta
	emit_signal("collectable_update", collected)
