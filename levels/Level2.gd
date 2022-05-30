extends Node2D

onready var spawnList = [
	$SpawnPoints/Point1,
	$SpawnPoints/Point2,
	$SpawnPoints/Point3,
	
]
var rng = RandomNumberGenerator.new()
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
	rng.randomize()
	var randomNumber = rng.randi_range(0,2)
	var playerPos = spawnList[randomNumber]
	var p = player.instance()
	p.global_position = playerPos.global_position
	p.global_position.y += 175
	$Player.add_child(p)
#	$Player.global_position = playerPos.global_position
