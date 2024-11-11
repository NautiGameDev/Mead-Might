extends Node3D

@onready var tavern_music = $tavernMusic

@onready var player_prepped = $playerPrepped
@onready var enemy_prepped = $enemyPrepped

@onready var chest = preload("res://Scenes/Units/chest.tscn")

@onready var buildBoard = $buildBoard

@onready var menu_click = $UI/PlayerUI/MenuClick

@onready var pause_menu = $PauseMenu
@onready var how_to = $HowTo

var submitted : bool = false



var tokens : int = 5

func _ready():
	Globals.playing = true
	submitted = false
	
	var heightSeed = randi_range(-50000, 50000)
	
	for j in get_tree().get_nodes_in_group("cell"):
		j.checkHeight(heightSeed)
		j.modifier.visible = true
	
	for i in tokens:
		player_prepped.drawToken()
		enemy_prepped.drawToken()
		
	startRound()

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if pause_menu.visible == false:
			pause_menu.visible = true
		elif pause_menu.visible == true:
			pause_menu.visible = false
	
func nextOpponent():
	await resetPlayers()
	await get_tree().create_timer(1).timeout
	await cleanBoard()
	await get_tree().create_timer(1).timeout
	await enemySetup()
	await get_tree().create_timer(1).timeout
	await changeBoard()
	await get_tree().create_timer(1).timeout
	await drawTokens()
	await get_tree().create_timer(1).timeout
	startRound()
	
	
func resetPlayers():
	var player1UI = get_tree().get_first_node_in_group("player1UI")
	var player2UI = get_tree().get_first_node_in_group("player2UI")
	
	player1UI.resetBoard()
	player2UI.resetBoard()
	
func cleanBoard():
	print("Cleaning up board")
	
	for i in get_tree().get_nodes_in_group("token"):
		if i.playerID == 1:
	
			var tokenParent = i.get_parent()
			var playerStash = get_tree().get_first_node_in_group("playerCollection")
			
			
			i.isPlaced = false
			i.basePosition = playerStash.global_position
			i.resetToken()
			
			tokenParent.remove_child(i)
			playerStash.add_child(i)
			i.global_position = playerStash.global_position
			
	for i in get_tree().get_nodes_in_group("decor"):
		i.queue_free()
			
			
	
func changeBoard():
	print("Changing board")
	var heightSeed = randi_range(-500000, 500000)
	
	buildBoard.play()
	
	await get_tree().create_timer(1).timeout
	
	for j in get_tree().get_nodes_in_group("cell"):
		j.freeCell()
		j.checkHeight(heightSeed)
		j.modifier.visible = true
		

func enemySetup():
	print("Setting up enemy")
	var enemyStash = get_tree().get_first_node_in_group("enemyCollection")
	enemyStash.setProb()
	
func drawTokens():
	print("Drawing tokens")
	for i in tokens:
		player_prepped.drawToken()
		enemy_prepped.drawToken()
		
func startRound():
	print("Starting round")
	
	var chestCount = 1
	
	for j in range(chestCount):
			
		
		var emptyCells = []
		var emptyCellCount = 0
		
		for i in get_tree().get_nodes_in_group("cell"):
			if i.hasUnit == false:
				emptyCells.append(i)
				emptyCellCount += 1
				
		emptyCellCount -= 1
		
		var randomCell = randi_range(0, emptyCellCount)
		
		await get_tree().create_timer(1).timeout
		var newChest = chest.instantiate()
		emptyCells[randomCell].add_child(newChest)
		newChest.basePosition = emptyCells[randomCell].global_position
		newChest.global_position = emptyCells[randomCell].global_position
		emptyCells[randomCell].hasUnit = true
	
	await get_tree().create_timer(1).timeout
	
	
	var unitHandler = get_tree().get_first_node_in_group("unitHandler")
	unitHandler.winnerDeclared = false
	
	var turnHandler = get_tree().get_first_node_in_group("turnHandler")
	turnHandler.roll()
	turnHandler.winnerDeclared = false


func _on_next_round_button_up():
	for i in get_tree().get_nodes_in_group("declareWinner"):
		i.visible = false
		
	var winsUI = get_tree().get_first_node_in_group("winsUI")
	winsUI.addWin()
	
	nextOpponent()
	menu_click.play()


func _on_main_menu_button_up():
	if submitted == false:
		submitted = true
		var score = get_tree().get_first_node_in_group("winsUI").wins
		SilentWolf.Scores.save_score(Globals.playerName, score)
	#	await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
