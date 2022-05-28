extends Control

onready var full_heart := load("res://Sprites/heart_full.png")
onready var empty_heart := load("res://Sprites/heart_empty.png")
export var timeLeft = 60

func _ready() -> void:
	Global.connect("life_changed", self,"update_life")
	Global.connect("collectabe_changed", self, "update_collectable")
	update_life(Global.life)
	$CanvasLayer/TimeLeft.text = str(timeLeft)
	$CanvasLayer/Collectable.text = str(Global.collected)+"/"+str(Global.to_collect)

func update_life(var life: int):
	var max_life := Global.max_life
	for N in $CanvasLayer/MarginContainer/HBoxContainer.get_children():
		if int(N.name) <= max_life:
			if int(N.name) <= life:
				N.texture = full_heart
			else:
				N.texture = empty_heart
			N.visible = true
		else:
			N.visible = false

func update_collectable(var collected: int):
	var max_to_collect := Global.to_collect;
	$CanvasLayer/Collectable.text = str(collected)+"/"+str(max_to_collect)
	

func _on_Timer_timeout():
	Global.update_life(-Global.max_life)


func _on_Timer_timeChanged(curr_time):
	$CanvasLayer/TimeLeft.text = str(curr_time)
