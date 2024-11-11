extends StaticBody3D

#States
var isHovered : bool = false
var isSelected : bool = false
var isPlaced : bool = false

#Token Stats
@export var playerID = 0
@export var damage = 0
@export var health = 0
@export var unitName = ""
@export var rarity = 0
@export var unitClass = ""
var baseHealth = health
var baseDamage = damage
var lastHitID = 0

#Mesh Handling
@onready var mesh = $token/RootNode/Skeleton3D/unit
var blackMat = preload("res://Scenes/Units/black.tres")
var whiteMat = preload("res://Scenes/Units/white.tres")
@onready var particles = $particles
@onready var damageText = preload("res://Scenes/damage.tscn")
@onready var unit_stats = $UnitStats
@onready var powerup = $powerUp


#Position Handling
var basePosition = Vector3()
var gridPos = null
@onready var damage_area = $damageArea

#Particles
var damageParticle = preload("res://Scenes/particles/damage_particle.tscn")
var healParticle = preload("res://Scenes/particles/heal_particle.tscn")
var buffParticle = preload("res://Scenes/particles/buff_particle.tscn")
var smokeParticle = preload("res://Scenes/particles/smoke_particle.tscn")
var unitParticle = preload("res://Scenes/particles/unit_particle.tscn")


##Sounds THESE NEED TO BE HOOKED UP IN THE CODE!!
@onready var place = $place
@onready var attack = $attack
@onready var buff = $buff

func _ready():
	baseHealth = health
	baseDamage = damage
	basePosition = self.global_position
	if playerID == 1:
		mesh.set_surface_override_material(0, blackMat)
	elif playerID == 2:
		mesh.set_surface_override_material(0, whiteMat)
		self.global_rotation_degrees.y = 180

func setColor():
	if playerID == 1:
		mesh.set_surface_override_material(0, blackMat)
	elif playerID == 2:
		mesh.set_surface_override_material(0, whiteMat)
		self.global_rotation_degrees.y = 180

func _process(delta):
	if isSelected && self.global_position.y <= 1:
		self.global_position.y += 0.1
		particles.emitting = true
	elif isSelected == false:
		self.global_position = basePosition
		
	if Input.is_action_just_pressed("leftClick") && isHovered:
		var unitHandler = get_tree().get_first_node_in_group("unitHandler")
		unitHandler.newUnit(self)
		#isSelected = true
		
	if health <= 0:
		handleDeath()

func handleDeath():
	if playerID == 0:
		return
	elif playerID != 3:
		var parentObj = self.get_parent()
		if parentObj && parentObj.is_in_group("cell"):
			parentObj.freeCell()
		health = baseHealth
		damage = baseDamage
		isPlaced = false
	
	
	if playerID == 1:
		var enemybag = get_tree().get_first_node_in_group("player2Bag")
		var particle = unitParticle.instantiate()
		get_tree().get_root().add_child(particle)
		particle.global_position = self.global_position
		particle.target = enemybag
		
		var enemyCollection = get_tree().get_first_node_in_group("enemyCollection")
		
		self.get_parent().remove_child(self)
		enemyCollection.add_child(self)
		basePosition = enemyCollection.global_position
		playerID = 2
		
		var opponentUI = get_tree().get_first_node_in_group("player1UI")
		opponentUI.updateHealth()
		
		var camera = get_tree().get_first_node_in_group("cameraNode")
		camera.applyShake()
		
		
	elif playerID == 2:
		var enemybag = get_tree().get_first_node_in_group("player1Bag")
		var particle = unitParticle.instantiate()
		get_tree().get_root().add_child(particle)
		particle.global_position = self.global_position
		particle.target = enemybag
		
		var playerCollection = get_tree().get_first_node_in_group("playerCollection")
		
		self.get_parent().remove_child(self)
		playerCollection.add_child(self)
		basePosition = playerCollection.global_position
		
		playerID = 1
		
		var opponentUI = get_tree().get_first_node_in_group("player2UI")
		opponentUI.updateHealth()
		
		var scoreUI = get_tree().get_first_node_in_group("scoreUI")
		var scoreIncrease = (rarity * 10) + (baseHealth * 10)
		scoreUI.addScore(scoreIncrease)
		var camera = get_tree().get_first_node_in_group("cameraNode")
		camera.applyShake()
	elif playerID == 3:
#		var chest = get_tree().get_first_node_in_group("chest")
		playerID = 0
		powerup.resolvePowerup(lastHitID)
		
		health = 0
		var scoreUI = get_tree().get_first_node_in_group("scoreUI")
		scoreUI.addScore(250)
		return
		
	resetTeam()

func resolvePowerup():
	var parentObj = self.get_parent()
	if parentObj && parentObj.is_in_group("cell"):
		parentObj.freeCell()
		
		
		self.queue_free()

func resetTeam():
	if playerID == 1:
		mesh.set_surface_override_material(0, blackMat)
		self.global_rotation_degrees.y = 0
	elif playerID == 2:
		mesh.set_surface_override_material(0, whiteMat)
		self.global_rotation_degrees.y = 180

func placed(cell):
	isSelected = false
	isPlaced = true
	particles.emitting = false
	gridPos = cell
	await get_tree().create_timer(0.5).timeout
	self.get_parent().loseChild(self)
	cell.add_child(self)
	
	place.play()
	
	await get_tree().create_timer(.1).timeout
	resolveDamage()
	
func resolveDamage():
	var isEnemy = false
	var orcTargets = 0
	
	for i in get_tree().get_nodes_in_group("token"):
		if i.playerID != 0:
			isEnemy = true
			var distance = i.global_position.distance_to(self.global_position)
			
			if unitClass == "warrior":
					
				if distance <= 1 && i.playerID != playerID:
					i.health -= damage
					var dmg = damageText.instantiate()
					dmg.damage = damage
					self.add_child(dmg)
					dmg.global_position = i.global_position
					
					var particle = damageParticle.instantiate()
					get_tree().get_root().add_child(particle)
					particle.global_position = i.global_position
					particle.emitting = true
					
				elif distance <= 1 && i.playerID == playerID:
					i.health += int(damage)
					var dmg = damageText.instantiate()
					dmg.damage = int(damage)
					dmg.color = Color(0.0,1.0,0.0,1.0)
					self.add_child(dmg)
					dmg.global_position = i.global_position
					
					var particle = healParticle.instantiate()
					get_tree().get_root().add_child(particle)
					particle.global_position = i.global_position
					particle.emitting = true
					
			elif unitClass == "mage":
				if distance <= 2 && i.playerID != playerID:
					i.health -= damage
					var dmg = damageText.instantiate()
					dmg.damage = damage
					self.add_child(dmg)
					dmg.global_position = i.global_position
					
					var particle = damageParticle.instantiate()
					get_tree().get_root().add_child(particle)
					particle.global_position = i.global_position
					particle.emitting = true
					
			elif unitClass == "human":
				if distance <= 1 && i.playerID == playerID:
					i.health += damage
#					if i.health > i.baseHealth:
#						i.health = i.baseHealth
					
					var dmg = damageText.instantiate()
					dmg.damage = damage
					dmg.color = Color(0.0,1.0,0.0,1.0)
					self.add_child(dmg)
					dmg.global_position = i.global_position
					
					var particle = healParticle.instantiate()
					get_tree().get_root().add_child(particle)
					particle.global_position = i.global_position
					particle.emitting = true
					
			elif unitClass == "undead":
				if distance <= 1 && i.playerID != playerID:
					i.health -= damage
					health += damage
					var dmg = damageText.instantiate()
					dmg.damage = damage
					self.add_child(dmg)
					dmg.global_position = i.global_position
					
					var particle = damageParticle.instantiate()
					get_tree().get_root().add_child(particle)
					particle.global_position = i.global_position
					particle.emitting = true
					
			elif unitClass == "orc":
				
				if distance <= 1 && i.playerID != playerID:
					i.health -= damage
					var dmg = damageText.instantiate()
					dmg.damage = damage
					self.add_child(dmg)
					dmg.global_position = i.global_position
					
					var particle = damageParticle.instantiate()
					get_tree().get_root().add_child(particle)
					particle.global_position = i.global_position
					particle.emitting = true
					orcTargets += 1
#
#					if playerID == 1:
#						var playerPrepped = get_tree().get_first_node_in_group("playerPrepped")
#						var prepSpots = playerPrepped.get_children()
#
#						for j in prepSpots:
#							var preppedUnit = j.get_child(0)
#							if preppedUnit:
#								preppedUnit.damage += 1
#								var boost = damageText.instantiate()
#								boost.damage = 1
#								boost.color = Color(0.0,0.0,1.0,1.0)
#								self.add_child(boost)
#								boost.global_position = j.global_position
#
#								var b_particle = buffParticle.instantiate()
#								get_tree().get_root().add_child(b_particle)
#								b_particle.global_position = j.global_position
#								b_particle.emitting = true
#
#					elif playerID == 2:
#						var playerPrepped = get_tree().get_first_node_in_group("enemyPrepped")
#						var prepSpots = playerPrepped.get_children()
#
#						for j in prepSpots:
#							var preppedUnit = j.get_child(0)
#							if preppedUnit:
#								preppedUnit.damage += 1
#								var boost = damageText.instantiate()
#								boost.damage = 1
#								boost.color = Color(0.0,0.0,1.0,1.0)
#								self.add_child(boost)
#								boost.global_position = j.global_position
#
#								var b_particle = buffParticle.instantiate()
#								get_tree().get_root().add_child(b_particle)
#								b_particle.global_position = j.global_position
#								b_particle.emitting = true
								
			elif unitClass == "goblin":
				if distance <= 1 && i.playerID == 3:
					i.health -= (damage * 2)
					var dmg = damageText.instantiate()
					dmg.damage = (damage * 2)
					self.add_child(dmg)
					dmg.global_position = i.global_position
					
					var particle = damageParticle.instantiate()
					get_tree().get_root().add_child(particle)
					particle.global_position = i.global_position
					particle.emitting = true
					
				elif distance <= 1 && i.playerID != playerID:
					i.health -= damage
					var dmg = damageText.instantiate()
					dmg.damage = damage
					self.add_child(dmg)
					dmg.global_position = i.global_position
					
					var particle = damageParticle.instantiate()
					get_tree().get_root().add_child(particle)
					particle.global_position = i.global_position
					particle.emitting = true
					
			else:
				if distance <= 1 && i.playerID != playerID:
					i.health -= damage
					var dmg = damageText.instantiate()
					dmg.damage = damage
					self.add_child(dmg)
					dmg.global_position = i.global_position
					
					var particle = damageParticle.instantiate()
					get_tree().get_root().add_child(particle)
					particle.global_position = i.global_position
					particle.emitting = true
			
			i.lastHitID = playerID
			
	if unitClass == "orc" && orcTargets > 0:
		if playerID == 1:
			var playerPrepped = get_tree().get_first_node_in_group("playerPrepped")
			var prepSpots = playerPrepped.get_children()
			
			for j in prepSpots:
				var preppedUnit = j.get_child(0)
				if preppedUnit:
					preppedUnit.damage += orcTargets
					var boost = damageText.instantiate()
					boost.damage = orcTargets
					boost.color = Color(0.0,0.0,1.0,1.0)
					self.add_child(boost)
					boost.global_position = j.global_position
					
					var b_particle = buffParticle.instantiate()
					get_tree().get_root().add_child(b_particle)
					b_particle.global_position = j.global_position
					b_particle.emitting = true
					
		elif playerID == 2:
			var playerPrepped = get_tree().get_first_node_in_group("enemyPrepped")
			var prepSpots = playerPrepped.get_children()
			
			for j in prepSpots:
				var preppedUnit = j.get_child(0)
				if preppedUnit:
					preppedUnit.damage += 1
					var boost = damageText.instantiate()
					boost.damage = 1
					boost.color = Color(0.0,0.0,1.0,1.0)
					self.add_child(boost)
					boost.global_position = j.global_position
					
					var b_particle = buffParticle.instantiate()
					get_tree().get_root().add_child(b_particle)
					b_particle.global_position = j.global_position
					b_particle.emitting = true
			
	if isEnemy == true:
		attack.play()
		
		if unitClass == "orc":
			buff.play()
	
	
func resetToken():
	health = baseHealth
	damage = baseDamage
	
func goblinDamage():
	await get_tree().create_timer(2).timeout
	var isEnemy = false
	for i in get_tree().get_nodes_in_group("token"):
		if i.playerID != 0:
			isEnemy = true
			
			
			var distance = i.global_position.distance_to(self.global_position)
		
			if distance <= 1 && i.playerID != playerID:
				i.health -= int(damage / 2)
				var dmg = damageText.instantiate()
				dmg.damage = int(damage / 2)
				self.add_child(dmg)
				dmg.global_position = i.global_position
				
				var particle = damageParticle.instantiate()
				get_tree().get_root().add_child(particle)
				particle.global_position = i.global_position
				particle.emitting = true
				
	if isEnemy == true:
		attack.play()

	
func smokeScreen():
	var particle = smokeParticle.instantiate()
	get_tree().get_root().add_child(particle)
	particle.global_position = self.global_position
	particle.emitting = true
	
	if playerID == 1:
		var playerCollection = get_tree().get_first_node_in_group("playerCollection")
		var rogueParent = self.get_parent()
		rogueParent.freeCell()
		rogueParent.remove_child(self)
		playerCollection.add_child(self)
		basePosition = playerCollection.global_position
		isPlaced = false
		resetToken()
	elif playerID == 2:
		var playerCollection = get_tree().get_first_node_in_group("enemyCollection")
		var rogueParent = self.get_parent()
		rogueParent.freeCell()
		rogueParent.remove_child(self)
		playerCollection.add_child(self)
		basePosition = playerCollection.global_position
		isPlaced = false
		resetToken()
		
	
		

	
func _on_hitbox_mouse_entered():
	if isPlaced == false:
		isHovered = true
		
	particles.emitting = true
	unit_stats.visible = true
	unit_stats.updateStats(unitName, damage, health)
	

func _on_hitbox_mouse_exited():
	isHovered = false
	if isSelected == false:
		particles.emitting = false
	unit_stats.visible = false


