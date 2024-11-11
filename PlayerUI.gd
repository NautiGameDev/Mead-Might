extends Sprite2D

@onready var playerHealth = $health
@onready var playerName = $name

@export var playerID = 0

@onready var declare_winner = $declareWinner
@onready var winner_label = $declareWinner/winnerLabel


@onready var sad = $Sad
@onready var applause = $Applause
var setScore : bool = false



var hp : int = 10

var opponentName = ""
var nameDic : Array = ["Ainsley", "Blythe", "Marlee", "Lindon", "Zephrine", "Elwine", "Everild", "Edgar", "Truman", "Avery", "Rae", "Brynlee", "Nellwyn", "Godbert", "Armundus", "Stevyn", "Adame", "Hubard", "Ansgot", "Hamett", "Adkin", "Reeve", "Emme", "Imayn", "Rosemond", "Mahenyld", "Moll"]

func _ready():
	setScore = false
	updateName()

func resetBoard():
	hp = 10
	playerHealth.text = str(hp)
	updateName()
	
func updateName():
	if playerID == 1:
		opponentName = Globals.playerName
		
	elif playerID == 2:
		var random = randi_range(0, nameDic.size() - 1)
		
		opponentName = str(nameDic[random])
	
	playerName.text = opponentName
		
func updateHealth():
	hp -= 1
	playerHealth.text = str(hp)
	
	if hp <= 0:
		if playerID == 1:
			var enemyUI = get_tree().get_first_node_in_group("player2UI")
			
			enemyUI.declareWinner()
			sad.play()
			
		
		elif playerID == 2:
			var playerUI = get_tree().get_first_node_in_group("player1UI")
			
			playerUI.declareWinner()
			
		

			applause.play()
			
func declareWinner():
		winner_label.text = opponentName + " wins!"
		declare_winner.visible = true
		var unitHandler = get_tree().get_first_node_in_group("unitHandler")
		unitHandler.winnerDeclared = true
		var turnHandler = get_tree().get_first_node_in_group("turnHandler")
		turnHandler.winnerDeclared = true
