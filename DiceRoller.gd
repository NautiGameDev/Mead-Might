extends CanvasLayer

@onready var random_number = $RandomNumber
@onready var dice_roll_end = $DiceRollEnd
@onready var P1_dice_number = $P1Dice/DiceNumber
@onready var P2_dice_number = $P2Dice/DiceNumber
@onready var p1_dice = $P1Dice
@onready var p2_dice = $P2Dice
@onready var sound_dice = $sound_dice

var player1Number = 1
var player2Number = 1

func rollDice():
	p1_dice.visible = true
	p2_dice.visible = true
	random_number.start()
	dice_roll_end.start()
	sound_dice.play()


func _on_random_number_timeout():
	player1Number = randi_range(1, 20)
	player2Number = randi_range(1, 20)
	
	P1_dice_number.text = str(player1Number)
	P2_dice_number.text = str(player2Number)


func _on_dice_roll_end_timeout():
	random_number.stop()
	
	if player1Number > player2Number:
		var parent = self.get_parent()
		parent.resolveFirst(1)
	elif player2Number > player1Number:
		var parent = self.get_parent()
		parent.resolveFirst(2)
	elif player1Number == player2Number:
		rollDice()
		return
		
	await get_tree().create_timer(3).timeout
	p1_dice.visible = false
	p2_dice.visible = false
