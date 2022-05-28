extends Node2D

signal timeChanged(curr_time)

export var time : float = 60
var timer : float = 0
signal timeout
func _process(delta):
	timer += delta
	emit_signal("timeChanged", floor(time-timer))
	if timer > time:
		timer = 0
		emit_signal('timeout')
