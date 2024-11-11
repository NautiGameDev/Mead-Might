extends Sprite2D

@onready var score_label = $ScoreLabel

var score = 0
var tempScore = 0

var millions = 0
var thousands = 0
var hundreds = 0

var milString = "000"
var thouString = "000"
var hundString = "000"

func _ready():
	updateScore()

func addScore(amt):
	score += amt
	calcScore()
	
func calcScore():
	millions = int(score / 1000000)
	
	if millions > 0:
		tempScore = score - (1000000 * millions)
	else:
		tempScore = score
			
	thousands = int(tempScore / 1000)
	
	if thousands > 0:
		tempScore = score - (1000 * thousands)
	else:
		tempScore = score
		
	hundreds = tempScore
	
	if millions > 0:
		if millions > 100:
			milString = str(millions)
		elif millions > 10:
			milString = "0" + str(millions)
		else:
			milString = "00" + str(millions)
	else:
		milString = "000"
	
	if thousands > 0:
		if thousands > 100:
			thouString = str(thousands)
		elif thousands > 10:
			thouString = "0" + str(thousands)
		else:
			thouString = "00" + str(thousands)
	else:
		thouString = "000"
		
	if hundreds > 0:
		if hundreds > 100:
			hundString = str(hundreds)
		elif hundreds > 10:
			hundString = "0" + str(hundreds)
		else:
			hundString = "00" + str(hundreds)
	else:
		hundString = "000"
		
	updateScore()
		
func updateScore():
	score_label.text = "Score: " + milString + "," + thouString + "," + hundString
	
