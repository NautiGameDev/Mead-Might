extends Node3D

@onready var announcement_label = $ChestAnnouncement/ChestWinner/AnnouncementLabel
@onready var unit_text = $ChestAnnouncement/ChestWinner/UnitText
@onready var powerup_sound = $powerupSound

@onready var chest_particle = $ChestParticle
@onready var smoke_particle = preload("res://Scenes/particles/smoke_particle.tscn")

@onready var healParticle = preload("res://Scenes/particles/heal_particle.tscn")
@onready var damageText = preload("res://Scenes/damage.tscn")
@onready var anim = $anim

func resolvePowerup(lastHitID):

	for i in get_tree().get_nodes_in_group("token"):
		if i.playerID == lastHitID && i.isPlaced == true:
			i.health += 5
			
			var dmg = damageText.instantiate()
			dmg.damage = 5
			dmg.color = Color(0.0,1.0,0.0,1.0)
			get_tree().get_root().add_child(dmg)
			dmg.global_position = i.global_position
			
			var particle = healParticle.instantiate()
			get_tree().get_root().add_child(particle)
			particle.global_position = i.global_position
			particle.emitting = true
			

	if lastHitID == 1:
		var playerName = get_tree().get_first_node_in_group("player1UI").opponentName
		announcement_label.text = playerName + " wins the health potion!"
		anim.play("open")
		await get_tree().create_timer(2).timeout
		anim.play("hideUI")
		
	elif lastHitID == 2:
		var playerName = get_tree().get_first_node_in_group("player2UI").opponentName
		announcement_label.text = playerName + " wins the health potion!"
		
		anim.play("open")
		await get_tree().create_timer(2).timeout
		anim.play("hideUI")
		
	powerup_sound.play()
	chest_particle.emitting = true
	
	var smoke = smoke_particle.instantiate()
	get_tree().get_root().add_child(smoke)
	smoke.global_position = self.global_position
	
	self.get_parent().resolvePowerup()
	
	
	
