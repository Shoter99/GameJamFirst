extends Control

onready var full_heart := load("res://Sprites/heart_full.png")
onready var empty_heart := load("res://Sprites/heart_empty.png")


func _ready() -> void:
	Global.connect("life_changed", self,"update_life")
	update_life(Global.life, Global.max_life)

func update_life(var life: int, var max_life: int):
	for N in $CanvasLayer/MarginContainer/HBoxContainer.get_children():
		if int(N.name) <= max_life:
			if int(N.name) <= life:
				N.texture = full_heart
			else:
				N.texture = empty_heart
			N.visible = true
		else:
			N.visible = false
