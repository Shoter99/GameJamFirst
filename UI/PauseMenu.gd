extends Control

var is_paused = false setget set_is_paused

func _unhandled_input(event):
	if event.is_action_pressed("pauseGame"):
		self.is_paused = !is_paused


func _on_Resume_pressed():
	self.is_paused = false
	
func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused

func _on_Exit_pressed():
	get_tree().quit()


func _on_MainMenu_pressed():
	get_tree().paused = false
	Global.reset_collected()
	get_tree().change_scene("res://UI/MainMenu.tscn")
