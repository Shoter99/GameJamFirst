extends Node2D
export var czas = 60
var timer = 0
signal timeout
func _process(delta):
	timer += delta
	if timer > czas:
		timer = 0
		emit_signal('timeout')
