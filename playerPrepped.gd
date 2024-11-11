extends Node3D

@onready var player_collection = $"../playerCollection"


@onready var spot1 = $playerPrepped1
@onready var spot2 = $playerPrepped2
@onready var spot3 = $playerPrepped3
@onready var spot4 = $playerPrepped4
@onready var spot5 = $playerPrepped5

@onready var newUnit = $newUnit




func _ready():
	pass

func organizeTokens():
	if spot1.get_child_count() < 1:
		var spot2Token = spot2.get_child(0)
		
		if spot2Token:
			spot2.loseChild(spot2Token)
			spot1.receiveChild(spot2Token)
			
	if spot2.get_child_count() < 1:
		var spot3Token = spot3.get_child(0)
		
		if spot3Token:
			spot3.loseChild(spot3Token)
			spot2.receiveChild(spot3Token)
			
	if spot3.get_child_count() < 1:
		var spot4Token = spot4.get_child(0)
		
		if spot4Token:
			spot4.loseChild(spot4Token)
			spot3.receiveChild(spot4Token)
			
	if spot4.get_child_count() < 1:
		var spot5Token = spot5.get_child(0)
		
		if spot5Token:
			spot5.loseChild(spot5Token)
			spot4.receiveChild(spot5Token)
			
	drawToken()

func drawToken():
	var tokens = player_collection.get_children()
		
	var random = randi_range(0, tokens.size() - 1)

	if spot1.get_child_count() < 1:
		player_collection.remove_child(tokens[random])
		spot1.receiveChild(tokens[random])
	elif spot2.get_child_count() < 1:
		player_collection.remove_child(tokens[random])
		spot2.receiveChild(tokens[random])
	elif spot3.get_child_count() < 1:
		player_collection.remove_child(tokens[random])
		spot3.receiveChild(tokens[random])
	elif spot4.get_child_count() < 1:
		player_collection.remove_child(tokens[random])
		spot4.receiveChild(tokens[random])
	elif spot5.get_child_count() < 1:
		player_collection.remove_child(tokens[random])
		spot5.receiveChild(tokens[random])
		
		
	newUnit.play()


func _on_button_button_up():
	organizeTokens()
