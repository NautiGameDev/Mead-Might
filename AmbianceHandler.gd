extends Node3D
@onready var crowd = $crowd

@onready var song1 = $song1
@onready var song2 = $song2
@onready var song3 = $song3
@onready var song4 = $song4
@onready var song5 = $song5
@onready var song6 = $song6

var songArray = [song1, song2, song3, song4, song5, song6]
var currentSong = null
var random = 0
var previous_numb = 0

func _ready():
	print(songArray)

func _process(delta):
	if crowd.playing == false:
		crowd.play()
		
	if currentSong == null:
		chooseSong()
		
func chooseSong():
	random = randi_range(1, 6)
	setSong()
	

func setSong():
	if random == previous_numb:
		chooseSong()
	else:
		previous_numb = random
		
		if random == 1:
			currentSong = song1
		elif random == 2:
			currentSong = song2
		elif random == 3:
			currentSong = song3
		elif random == 4:
			currentSong = song4
		elif random == 5:
			currentSong = song5
		elif random == 6:
			currentSong = song6
			
		currentSong.play()
		await currentSong.finished
		currentSong = null
		
