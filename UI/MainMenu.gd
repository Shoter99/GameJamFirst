extends Control






func _on_Start_pressed():
	get_tree().change_scene("res://levels/final levels/Level1.tscn")


func _on_Credits_pressed():
	$CreditsText.visible = true


func _on_Button_pressed():
	$CreditsText.visible = false


func _on_Exit_pressed():
	get_tree().quit()
