extends Area2D

onready var player = get_tree().get_nodes_in_group("Player")[0]

	


func _on_WaterTileArea_body_entered(body):
	#print("a")
	if body.is_in_group("Player"):
		#player.get_child(0).velocity.y = -1000
		player.get_child(0).inWater = true
		#print("Entered water")



func _on_WaterTileArea_body_exited(body):
	if body.is_in_group("Player"):
		player.get_child(0).inWater = false
		#print("Got out of water")
		#player.get_child(0).velocity.y = -1000
