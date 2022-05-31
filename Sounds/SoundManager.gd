extends Node2D


func _ready():
	Global.connect("jump", self, "_on_jump")
	Global.connect("takeDamage", self, "_on_takeDamage")

func _on_jump():
	$Jump.play()
func _on_takeDamage():
	$TakeDamage.play()

func _process(delta):
	if $BgMusic.playing == false:
		$BgMusic.play()
