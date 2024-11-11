extends GPUParticles3D

@onready var chest_open = $ChestOpen
@onready var chest_magic = $ChestMagic


func _ready():
	chest_open.play()
	chest_magic.play()
	
	await get_tree().create_timer(5).timeout
	self.queue_free()
