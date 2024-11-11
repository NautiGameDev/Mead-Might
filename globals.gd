extends Node

var playerName = "Player"
var bestScore : int = 0
var bestWins : int = 0

var playing : bool = false

var volumeMaster = 100
var volumeMusic = 100
var volumeAmbiance = 100
var volumeSFX = 100

var volumetricFog : bool = true
var shadows : bool = true

func _ready():
	SilentWolf.configure({"api_key": "*********",
	"game_id": "*******",
	"log_level": 1})

	SilentWolf.configure_scores({"open_scene_on_close": "res://Scenes/leaderboard.tscn"})


func setScore(score):
	SilentWolf.Scores.save_score(Globals.playerName, score)

func setBestScore(score, wins):
	if score > bestScore:
		bestScore = score
	
	if wins > bestWins:
		bestWins = wins
