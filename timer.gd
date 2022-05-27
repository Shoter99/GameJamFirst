extends Node2D

export var time : float = 60
var timer : float = 0
signal timeout
func _process(delta):
	timer += delta
	if timer > time:
		timer = 0
		emit_signal('timeout')
