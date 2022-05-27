extends Control


func _ready():
	hide()
	$TextureProgress.value = 100

func set_percent_value(value : int):
	if(visible == false  and value != 100): show()
	$TextureProgress.value = value
