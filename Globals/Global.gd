extends Node


var max_life : int= 3
var life : int = 0
var collected : int = 0
var to_collect
var current_evolution := [1,0,0,0,0,0,0,0,0]
var currentEvolutionNo = 0
var canEvolve = false
var currentLevel = int(0)
var spawnAtEnd = false
export var currentCheckpoint = 0
signal life_changed(life)
signal collectabe_changed(collected)
signal jump
signal evolution
signal takeDamage
signal evolve


onready var evolution0 := preload("res://Player/scenes/Evolution0.tscn")
onready var evolution1 := preload("res://Player/scenes/Evolution1.tscn")
onready var evolution2 := preload("res://Player/scenes/Evolution2.tscn")
onready var evolution3 := preload("res://Player/scenes/Evolution3.tscn")
onready var evolution4 := preload("res://Player/scenes/Evolution4.tscn")
onready var evolution5 := preload("res://Player/scenes/Evolution5.tscn")
onready var evolution6 := preload("res://Player/scenes/Evolution6.tscn")
onready var evolution7 := preload("res://Player/scenes/Evolution7.tscn")
#onready var evolution8 := preload("res://Player/scenes/Evolution8.tscn")

onready var levels = ["res://levels/final levels/Level1.tscn", "res://levels/final levels/Level2.tscn", "res://levels/final levels/Level3.tscn", "res://levels/final levels/FinalLevel.tscn"]


func _ready():
#	connect("evolve", self, go_to_next_evolution())
	pass

func update_life(var delta: int):
	if delta < 0:
		emit_signal("takeDamage")
	life+=delta
	emit_signal("life_changed", life)
	if life <= 0: restart_level()

func set_life(var delta: int):
	life=delta
	emit_signal("life_changed", life)

func update_collectable(var delta: int):
	collected+=delta
	if(collected<0 ): collected = 0
	emit_signal("collectabe_changed", collected)
	if collected >= to_collect:
		canEvolve = true
		emit_signal("evolve")
#		if current_evolution[currentEvolutionNo] == 1:
#			current_evolution[currentEvolutionNo] = 0
#			current_evolution[currentEvolutionNo+1] = 1
#		currentEvolutionNo +=1
#		restart_level()
#		get_tree().change_scene("res://UI/Tutorial.tscn")

func go_to_next_evolution():
	if currentEvolutionNo == 7:
		return
	if current_evolution[currentEvolutionNo] == 1:
			current_evolution[currentEvolutionNo] = 0
			current_evolution[currentEvolutionNo+1] = 1
	if currentEvolutionNo < 7:
		currentEvolutionNo +=1
	restart_level()
	get_tree().change_scene("res://UI/Tutorial.tscn")

func restart_level():
	canEvolve = false
	reset_collected()
	get_tree().reload_current_scene()

func reset_collected():
	life = 0
	collected = 0

func set_start_options(var life: int, var collect: int):
	max_life = life
	set_life(max_life)
	to_collect = collect

func _unhandled_input(event):
	if event.is_action_pressed("restartLevel"):
		restart_level()
