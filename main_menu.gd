extends Node3D

@onready var player_name = $MenuUI/PlayUI/playerName
@onready var menu_click = $AmbianceHandler/MenuClick

func _ready():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	
func _on_accept_button_up():
	if player_name.text:
		Globals.playerName = player_name.text

		var tree = get_tree()
		
		get_tree().change_scene_to_file("res://Scenes/gameplay.tscn")
		
		menu_click.play()
		
	else:
		player_name.placeholder_text = "Please sign your name"
