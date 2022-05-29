extends Node2D



func _ready():
	for i in 3:
		if Global.current_evolution[i] == 1:
			match i:
				0:
					createPlayer(Global.evolution0)
				1:
					createPlayer(Global.evolution1)
				2:
					createPlayer(Global.evolution2)
					
		
func createPlayer(player):
	var p = player.instance()
	p.global_position = $PlayerSpawn.global_position
	$Player.add_child(p)
	
