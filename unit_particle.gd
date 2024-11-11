extends GPUParticles3D

var target = null
var speed = 5

@onready var token_death_1 = $tokenDeath1
@onready var token_death_2 = $tokenDeath2
@onready var token_death_3 = $tokenDeath3
@onready var token_death_4 = $tokenDeath4
@onready var token_death_5 = $tokenDeath5


func _ready():
	var random = randi_range(1, 5)
	
	if random == 1:
		token_death_1.play()
	elif random == 2:
		token_death_2.play()
	elif random == 3:
		token_death_3.play()
	elif random == 4:
		token_death_4.play()
	elif random == 5:
		token_death_5.play()


func _process(delta):
	if target:
		var direction = (self.global_position - target.global_position)
		direction = direction.normalized()
		
		
		self.global_position.x -= direction.x * speed * delta
		self.global_position.z -= direction.z * speed * delta
		
		var selfpos = Vector2(self.global_position.x, self.global_position.z)
		var targpos = Vector2(target.global_position.x, target.global_position.z)
		
		var distance = targpos.distance_to(selfpos)
		
		if distance <= 0.5:
			self.queue_free()
