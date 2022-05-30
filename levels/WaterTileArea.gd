extends Area2D

onready var player = get_tree().get_nodes_in_group("Player")[0]

	


func _on_WaterTileArea_body_entered(body):
	#print("a")
	if body.is_in_group("Player"):
		#player.get_child(0).velocity.y = -1000
		player.get_child(0).inWater = true
		#print("Entered water")
		#print("GhostNode123".left(9))
	#print(body.name)
	if body.name.left(10) == "GhostEnemy":
		body.hurt_and_die(1)



func _on_WaterTileArea_body_exited(body):
	if body.is_in_group("Player"):
		player.get_child(0).inWater = false
		#print("Got out of water")
		#player.get_child(0).velocity.y = -1000
