extends Node


var max_life : int= 3
var life : int = 0
var collected : int = 0
var to_collect
var current_evolution := [1,0,0]
export var currentCheckpoint = 0
signal life_changed(life)
signal collectabe_changed(collected)
signal jump
signal evolution
signal takeDamage

onready var evolution0 := preload("res://Player/Evolution0.tscn")
onready var evolution1 := preload("res://Player/Evolution1.tscn")
onready var evolution2 := preload("res://Player/Evolution2.tscn")


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
		if current_evolution[0] == 1:
			current_evolution[0] = 0
			current_evolution[1] = 1
		elif current_evolution[1] == 1:
			current_evolution[1] = 0
			current_evolution[2] = 1
		restart_level()
	
func restart_level():
	life = 0
	collected = 0
	get_tree().reload_current_scene()


func set_start_options(var life: int, var collect: int):
	max_life = life
	set_life(max_life)
	to_collect = collect
