extends Node3D
@onready var crowd = $Crowd
@onready var menu_music = $MenuMusic


func _process(delta):
#	if crowd.playing == false:
#		crowd.play()
		
	if menu_music.playing == false:
		menu_music.play()
