extends Control


var tutorials = [
	{
		"title": "Jump Evolution",
		"description": "Thanks to your new legs now you can jump(using spacebar)",
		"video": preload("res://videos/JumpEvo.webm")
	},
	{
		"title": "Swimming Evolution",
		"description": "You've just unlocked ability to swim, now you can discover what hides under water",
		"video": preload("res://videos/SwimEvo.webm")
	},
	{
		"title": "Double Jump Evolution",
		"description": "Thanks to your new pair of wings now you can jump while mid air",
		"video": preload("res://videos/WingsEvo.webm")
	},
	{
		"title": "Wall Jump Evolution",
		"description": "Thanks to the freshly grown limbs you can stick to walls and access new locations",
		"video": preload("res://videos/HandsEvo.webm")
	},
	{
		"title": "Dash Evolution",
		"description": "Now you can dash in a given direction evading enemies(using shift)",
		"video": preload("res://videos/DashEvo.webm")
	},
	{
		"title": "Glide Evolution",
		"description": "Gliding will give you access to new undiscovered location(using alt)",
		"video": preload("res://videos/GlideEvo.webm")
	},
	{
		"title": "Shooting Evolution",
		"description": "Thanks to your new ability to shoot now you will have easier time dealing with ranged enemies(using f)",
		"video": preload("res://videos/ShootEvo.webm")
	}


]

func _ready():
	var evo : int = Global.currentEvolutionNo
	$VBoxContainer/TutorialTitle.text = tutorials[evo-1].title
	$VBoxContainer/TutorialDesc.text = tutorials[evo-1].description
	$VideoPlayer.stream = tutorials[evo-1].video


func _on_Button_pressed():
	get_tree().change_scene("res://levels/final levels/Level1.tscn")
