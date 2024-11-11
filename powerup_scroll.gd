extends Node3D

@onready var announcement_label = $ChestAnnouncement/ChestWinner/AnnouncementLabel
@onready var unit_text = $ChestAnnouncement/ChestWinner/UnitText
@onready var powerup_sound = $powerupSound

@onready var chest_particle = $ChestParticle
@onready var smoke_particle = preload("res://Scenes/particles/smoke_particle.tscn")

@onready var buffParticle = preload("res://Scenes/particles/buff_particle.tscn")
@onready var damageText = preload("res://Scenes/damage.tscn")

@onready var anim = $anim


func resolvePowerup(lastHitID):

	if lastHitID == 1:
		var playerName = get_tree().get_first_node_in_group("player1UI").opponentName
		announcement_label.text = playerName + " wins the scroll!"
		anim.play("open")
		await get_tree().create_timer(2).timeout
		anim.play("hideUI")


		var playerPrepped = get_tree().get_first_node_in_group("playerPrepped")
		var prepSpots = playerPrepped.get_children()
		
		for j in prepSpots:
			var preppedUnit = j.get_child(0)
			if preppedUnit:
				preppedUnit.damage += 3
				var boost = damageText.instantiate()
				boost.damage = 3
				boost.color = Color(0.0,0.0,1.0,1.0)
				get_tree().get_root().add_child(boost)
				boost.global_position = j.global_position
				
				var b_particle = buffParticle.instantiate()
				get_tree().get_root().add_child(b_particle)
				b_particle.global_position = j.global_position
				b_particle.emitting = true




		
	elif lastHitID == 2:
		var playerName = get_tree().get_first_node_in_group("player2UI").opponentName
		announcement_label.text = playerName + " wins the scroll!"
		
		anim.play("open")
		await get_tree().create_timer(2).timeout
		anim.play("hideUI")
		
		var playerPrepped = get_tree().get_first_node_in_group("enemyPrepped")
		var prepSpots = playerPrepped.get_children()
		
		for j in prepSpots:
			var preppedUnit = j.get_child(0)
			if preppedUnit:
				preppedUnit.damage += 3
				var boost = damageText.instantiate()
				boost.damage = 3
				boost.color = Color(0.0,0.0,1.0,1.0)
				get_tree().get_root().add_child(boost)
				boost.global_position = j.global_position
				
				var b_particle = buffParticle.instantiate()
				get_tree().get_root().add_child(b_particle)
				b_particle.global_position = j.global_position
				b_particle.emitting = true
		
	powerup_sound.play()
	chest_particle.emitting = true
	
	var smoke = smoke_particle.instantiate()
	get_tree().get_root().add_child(smoke)
	smoke.global_position = self.global_position
	
	
	self.get_parent().resolvePowerup()
	
	
	
