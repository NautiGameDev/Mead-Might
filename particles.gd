extends GPUParticles3D

func _ready():
	await get_tree().create_timer(5).timeout
	self.queue_free()
