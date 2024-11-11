extends Node3D

@onready var announcement_label = $ChestAnnouncement/ChestWinner/AnnouncementLabel
@onready var unit_text = $ChestAnnouncement/ChestWinner/UnitText
@onready var powerup_sound = $powerupSound

@onready var chest_particle = $ChestParticle
@onready var smoke_particle = preload("res://Scenes/particles/smoke_particle.tscn")

@onready var anim = $anim

func resolvePowerup(lastHitID):

	for i in get_tree().get_nodes_in_group("token"):
		if i.playerID == lastHitID && i.isPlaced == true:
			i.resolveDamage()

	if lastHitID == 1:
		var playerName = get_tree().get_first_node_in_group("player1UI").opponentName
		announcement_label.text = playerName + " wins the vanquisher!"
		
		anim.play("open")
		await get_tree().create_timer(2).timeout
		anim.play("hideUI")
		
	elif lastHitID == 2:
		var playerName = get_tree().get_first_node_in_group("player2UI").opponentName
		announcement_label.text = playerName + " wins the vanquisher!"
		
		anim.play("open")
		await get_tree().create_timer(2).timeout
		anim.play("hideUI")
		
	powerup_sound.play()
	chest_particle.emitting = true
	
	var smoke = smoke_particle.instantiate()
	get_tree().get_root().add_child(smoke)
	smoke.global_position = self.global_position
	

	self.get_parent().resolvePowerup()
	
	
	
