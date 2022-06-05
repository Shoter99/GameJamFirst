extends Control


var tutorials = [
	{
		"title": "Jump Evolution",
		"description": "Thanks to your new legs now you can jump",
		"video": preload("res://videos/GameJamFirst (DEBUG) 2022-06-05 10-51-33.webm")
	},
	{
		"title": "Swimming Evolution",
		"description": "You've just unlocked ability to swim, now you can discover what hides under water",
		"video": preload("res://videos/GameJamFirst (DEBUG) 2022-06-05 10-51-33.webm")
	},
	{
		"title": "Double Jump",
		"description": "Thanks to your new pair of wings now you can jump while mid air",
		"video": preload("res://videos/GameJamFirst (DEBUG) 2022-06-05 10-51-33.webm")
	},
	{
		"title": "New pair of hands",
		"description": "Thanks to the freshly grown limbs you can stick to walls and access new locations",
		"video": preload("res://videos/GameJamFirst (DEBUG) 2022-06-05 10-51-33.webm")
	},
	{
		"title": "Dash evolution",
		"description": "Now you can dash in a given direction evading enemies or destroying walls",
		"video": preload("res://videos/GameJamFirst (DEBUG) 2022-06-05 10-51-33.webm")
	},
	{
		"title": "Shooting evolution",
		"description": "Thanks to your new ability to shoot now you will have easier time dealing with ranged enemies",
		"video": preload("res://videos/GameJamFirst (DEBUG) 2022-06-05 10-51-33.webm")
	},
	{
		"title": "Glide evolution",
		"description": "Gliding will give you access to new undiscovered location",
		"video": preload("res://videos/GameJamFirst (DEBUG) 2022-06-05 10-51-33.webm")
	},



]

func _ready():
	var evo : int = Global.currentEvolutionNo
	$VBoxContainer/TutorialTitle.text = tutorials[evo-1].title
	$VBoxContainer/TutorialDesc.text = tutorials[evo-1].description
	$VideoPlayer.stream = tutorials[evo-1].video


func _on_Button_pressed():
	get_tree().change_scene("res://levels/final levels/Level1.tscn")
