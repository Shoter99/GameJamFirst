extends Node2D

var rng = RandomNumberGenerator.new()
onready var spawnList = $SpawnPoints.get_children()
onready var checkpointCount = $SpawnPoints.get_child_count()
func _ready():
	
	for i in 8:
		if Global.current_evolution[i] == 1:
			match i:
				0:
					createPlayer(Global.evolution0)
				1:
					createPlayer(Global.evolution1)
				2:
					createPlayer(Global.evolution2)
				3:
					createPlayer(Global.evolution3)
				4:
					createPlayer(Global.evolution4)
				5:
					createPlayer(Global.evolution5)
				6:
					createPlayer(Global.evolution6)
				7:
					createPlayer(Global.evolution7)
	for j in checkpointCount:
		#print(j)
		spawnList[j].id = j
		
func createPlayer(player):
	var playerPos = spawnList[Global.currentCheckpoint]
	var p = player.instance()
	p.global_position = playerPos.global_position
	#p.global_position.y += 175
	$Player.add_child(p)
#	$Player.global_position = playerPos.global_position
