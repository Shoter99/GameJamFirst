extends Particles2D


func _ready():
	$AudioStreamPlayer2D.play()
	emitting = true

func _process(_delta):
	if !emitting:
		queue_free()
