extends Node3D
@onready var wand = $Wand

var blackMat = preload("res://Scenes/Units/black.tres")
var whiteMat = preload("res://Scenes/Units/white.tres")

func _process(delta):
	var parent = self.get_parent()
	
	if parent.playerID == 1:
		wand.set_surface_override_material(0, blackMat)
	elif parent.playerID == 2:
		wand.set_surface_override_material(0, whiteMat)
