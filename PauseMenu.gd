extends CanvasLayer

@onready var options_menu = $"../OptionsMenu"
@onready var instructions = $"../Instructions"
@onready var menu_click = $"../menuClick"


func _process(delta):
	if self.visible == false:
		options_menu.visible = false
		instructions.visible = false


func _on_resume_button_button_up():
	self.visible = false
	menu_click.play()


func _on_instructions_button_up():
	if instructions.visible == false:
		instructions.visible = true
		options_menu.visible = false
	elif instructions.visible == true:
		instructions.visible = false
		options_menu.visible = false
	menu_click.play()

func _on_main_menu_button_up():
	self.visible = false
	
	var score = get_tree().get_first_node_in_group("winsUI").wins
	SilentWolf.Scores.save_score(Globals.playerName, score)
	
	menu_click.play()
	
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_quit_button_up():
	var score = get_tree().get_first_node_in_group("winsUI").wins
	SilentWolf.Scores.save_score(Globals.playerName, score)
	menu_click.play()
	get_tree().quit()


func _on_options_button_button_up():
	menu_click.play()
	if options_menu.visible == false:
		options_menu.visible = true
		instructions.visible = false
	elif options_menu.visible == true:
		options_menu.visible = false
		instructions.visible = false
