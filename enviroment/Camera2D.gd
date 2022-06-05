extends Camera2D

onready var player = get_tree().get_nodes_in_group("Player")[0]

func _process(delta):
	global_position = player.get_child(0).global_position
