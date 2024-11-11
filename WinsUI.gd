extends Sprite2D

@onready var wins_label = $WinsLabel
var wins = 0
var hasWon : bool = false

func _ready():
	updateWins()

func addWin():
	if hasWon == false:
		hasWon = true
		wins += 1
		updateWins()
		await get_tree().create_timer(5).timeout
		hasWon = false
	
func updateWins():
	wins_label.text = "Wins: " + str(wins)
