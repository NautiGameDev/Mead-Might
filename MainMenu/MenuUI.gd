extends CanvasLayer

@onready var play_ui = $PlayUI

@onready var player_name = $PlayUI/playerName


@onready var instructions = $Instructions2
@onready var options_menu = $"../OptionsMenu"
@onready var leaderboard = $"../LeaderBoard"

@onready var menu_click = $"../AmbianceHandler/MenuClick"

func _ready():
	Globals.playing = false
	
	var heightSeed = randi_range(-500000, 500000)
	
	for j in get_tree().get_nodes_in_group("cell"):
		j.freeCell()
		j.checkHeight(heightSeed)


func _on_play_button_button_up():
	if play_ui.visible == false:
		play_ui.visible = true
		instructions.visible = false
		options_menu.visible = false
		leaderboard.visible = false
		
	elif play_ui.visible == true:
		play_ui.visible = false
		instructions.visible = false
		options_menu.visible = false
		leaderboard.visible = false

	menu_click.play()

func _on_quit_button_up():
	get_tree().quit()
	menu_click.play()




func _on_instructions_button_up():
	if instructions.visible == false:
		play_ui.visible = false
		instructions.visible = true
		options_menu.visible = false
		leaderboard.visible = false
	elif instructions.visible == true:
		play_ui.visible = false
		instructions.visible = false
		options_menu.visible = false
		leaderboard.visible = false
	
	menu_click.play()


func _on_options_button_up():
	if options_menu.visible == false:
		options_menu.visible = true
		play_ui.visible = false
		instructions.visible = false
		leaderboard.visible = false
	else:
		options_menu.visible = false
		play_ui.visible = false
		instructions.visible = false
		leaderboard.visible = false
		
	menu_click.play()
		
	
func _on_leader_boards_button_button_up():
	if leaderboard.visible == false:
		leaderboard.visible = true
		options_menu.visible = false
		play_ui.visible = false
		instructions.visible = false
		
	elif leaderboard.visible == true:
		leaderboard.visible = false
		options_menu.visible = false
		play_ui.visible = false
		instructions.visible = false

	menu_click.play()
