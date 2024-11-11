extends WorldEnvironment

func _process(delta):
	if Globals.volumetricFog == false:
		self.environment.volumetric_fog_enabled = false
		
	elif Globals.volumetricFog == true:
		
		self.environment.volumetric_fog_enabled = true
