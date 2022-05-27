extends Node


var max_life := 7
var life := 4

signal life_changed(life)

func update_life(var delta: int):
	life+=delta
	emit_signal("life_changed", life)
	if life < 0: pass
