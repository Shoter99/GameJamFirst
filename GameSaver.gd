extends Node


const SaveGame = preload ('res://Save.gd')

var saveFolder : String = 'res://SaveFolder'
var saveNameTemplate : String = 'save_%03d.tres'

func save (id : int):
	var saveGame := SaveGame.new()
	for node in get_tree().get_nodes_in_group('save'):
		node.save(saveGame)
	
	var directory : Directory = Directory.new()
	if not directory.dir_exists(saveFolder):
		directory.make_dir_recursive(saveFolder)
		
	var savePath = saveFolder.plus_file(saveNameTemplate % id)
	var error : int = ResourceSaver.save(savePath, saveGame)
	#if error != OK:
		#print ('An issue occured while saving')
		
func load (id : int):
	var saveFilePath : String = saveFolder.plus_file(saveNameTemplate % id)
	var file : File = File.new()
	if not file.file_exists(saveFilePath):
		#print ('Save file does not exist')
		return
	var saveGame : Resource = load(saveFilePath)
	for node in get_tree().get_nodes_in_group('save'):
		node.load(saveGame)
