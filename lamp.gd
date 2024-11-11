extends Node3D

@onready var omni_light_3d = $OmniLight3D

func _process(delta):
	if Globals.shadows == false:
		omni_light_3d.shadow_enabled = false
	elif Globals.shadows == true:
		omni_light_3d.shadow_enabled = true
