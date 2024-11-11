extends Node3D

var step = 0.35

var commonProb = 1
var uncommonProb = 0
var rareProb = 0
var legendaryProb = 0

## Common
var warriorFootman = preload("res://Scenes/Units/warrior_footman.tscn")
var elfThief = preload("res://Scenes/Units/elf_thief.tscn")
var mageAdept = preload("res://Scenes/Units/mage_adept.tscn")
var undeadZombie = preload("res://Scenes/Units/undead_zombie.tscn")
var humanPeasant = preload("res://Scenes/Units/human_peasant.tscn")
var orcScout = preload("res://Scenes/Units/orc_scout.tscn")
var goblinFighter = preload("res://Scenes/Units/goblin_fighter.tscn")

##Uncommon
var warriorSquire = preload("res://Scenes/Units/warrior_squire.tscn")
var elfArcher = preload("res://Scenes/Units/elf_archer.tscn")
var mageAlchemist = preload("res://Scenes/Units/mage_alchemist.tscn")
var undeadSkeleton = preload("res://Scenes/Units/undead_skeleton.tscn")
var humanAcolyte = preload("res://Scenes/Units/human_acolyte.tscn")
var orcZealot = preload("res://Scenes/Units/orc_zealot.tscn")
var goblinSpearman = preload("res://Scenes/Units/goblin_spearman.tscn")

##Rare
var warriorKnight = preload("res://Scenes/Units/warrior_knight.tscn")
var elfMercenary = preload("res://Scenes/Units/elf_mercenary.tscn")
var mageSpellSlinger = preload("res://Scenes/Units/mage_spellslinger.tscn")
var undeadWraith = preload("res://Scenes/Units/undead_wraith.tscn")
var humanMonk = preload("res://Scenes/Units/human_monk.tscn")
var orcShaman = preload("res://Scenes/Units/orc_shaman.tscn")
var goblinShaman = preload("res://Scenes/Units/goblin_shaman.tscn")

##Legendary
var warriorChallenger = preload("res://Scenes/Units/warrior_challenger.tscn")
var elfAssassin = preload("res://Scenes/Units/elf_assassin.tscn")
var mageSorcerer = preload("res://Scenes/Units/mage_sorcerer.tscn")
var undeadNecromancer = preload("res://Scenes/Units/undead_necromancer.tscn")
var humanDruid = preload("res://Scenes/Units/human_druid.tscn")
var orcSkirmisher = preload("res://Scenes/Units/orc_skirmisher.tscn")
var goblinKing = preload("res://Scenes/Units/goblin_king.tscn")

func setProb():
	if commonProb > uncommonProb:
		commonProb -= step
		uncommonProb += step
	elif uncommonProb > rareProb:
		uncommonProb -= step
		rareProb += step
	elif rareProb > legendaryProb:
		rareProb -= step
		legendaryProb += step
	elif rareProb <= legendaryProb && legendaryProb < 1:
		rareProb -= step
		legendaryProb += step
		
	emptyCollection()		

func emptyCollection():
	for i in get_tree().get_nodes_in_group("token"):
		if i.playerID == 2:
			i.queue_free()
			
	generateCollection()
			
func generateCollection():
	for i in range(20):
		var random = randf_range(0, 1)
		
		if random <= commonProb:
			var randomToken = randi_range(1, 7)
			
			if randomToken == 1:
				spawnWarriorFootman()
			elif randomToken == 2:
				spawnElfThief()
			elif randomToken == 3:
				spawnMageAdept()
			elif randomToken == 4:
				spawnUndeadZombie()
			elif randomToken == 5:
				spawnHumanPeasant()
			elif randomToken == 6:
				spawnOrcScout()
			elif randomToken == 7:
				spawnGoblinFighter()
			
		elif random > commonProb && random < (commonProb + uncommonProb):
			var randomToken = randi_range(1, 7)
			
			if randomToken == 1:
				spawnWarriorSquire()
			elif randomToken == 2:
				spawnElfArcher()
			elif randomToken == 3:
				spawnMageAlchemist()
			elif randomToken == 4:
				spawnUndeadSkeleton()
			elif randomToken == 5:
				spawnHumanAcolyte()
			elif randomToken == 6:
				spawnOrcZealot()
			elif randomToken == 7:
				spawnGoblinSpearman()
			
		elif random > (commonProb + uncommonProb) && random < (commonProb + uncommonProb + rareProb):
	
			var randomToken = randi_range(1, 7)
			
			if randomToken == 1:
				spawnWarriorKnight()
			elif randomToken == 2:
				spawnElfMercenary()
			elif randomToken == 3:
				spawnMageSpellSlinger()
			elif randomToken == 4:
				spawnUndeadWraith()
			elif randomToken == 5:
				spawnHumanMonk()
			elif randomToken == 6:
				spawnOrcShaman()
			elif randomToken == 7:
				spawnGoblinShaman()
	
		elif random > (commonProb + uncommonProb + rareProb) && random < (commonProb + uncommonProb + rareProb + legendaryProb):
			var randomToken = randi_range(1, 7)
			
			if randomToken == 1:
				spawnWarriorChallenger()
			elif randomToken == 2:
				spawnElfAssassin()
			elif randomToken == 3:
				spawnMageSorcerer()
			elif randomToken == 4:
				spawnUndeadNecromancer()
			elif randomToken == 5:
				spawnHumanDruid()
			elif randomToken == 6:
				spawnOrcSkirmisher()
			elif randomToken == 7:
				spawnGoblinKing()
			
			
func spawnWarriorFootman():
	var newToken = warriorFootman.instantiate()
	self.add_child(newToken)
	newToken.playerID = 2
	newToken.setColor()
	newToken.global_position = self.global_position
	print("Giving enemy warrior footman")
	
func spawnElfThief():
	var newToken = elfThief.instantiate()
	self.add_child(newToken)
	newToken.playerID = 2
	newToken.setColor()
	newToken.global_position = self.global_position
	print("Giving enemy Elf Thief")
	
func spawnMageAdept():
	var newToken = mageAdept.instantiate()
	self.add_child(newToken)
	newToken.playerID = 2
	newToken.setColor()
	newToken.global_position = self.global_position
	print("Giving enemy Mage Adept")
	
func spawnUndeadZombie():
	var newToken = undeadZombie.instantiate()
	self.add_child(newToken)
	newToken.playerID = 2
	newToken.setColor()
	newToken.global_position = self.global_position
	print("Giving enemy Undead Zombie")
	
func spawnHumanPeasant():
	var newToken = humanPeasant.instantiate()
	self.add_child(newToken)
	newToken.playerID = 2
	newToken.setColor()
	newToken.global_position = self.global_position
	print("Giving enemy human peasant")
	
func spawnOrcScout():
	var newToken = orcScout.instantiate()
	self.add_child(newToken)
	newToken.playerID = 2
	newToken.setColor()
	newToken.global_position = self.global_position
	print("Giving enemy orc scout")
	
func spawnGoblinFighter():
	var newToken = goblinFighter.instantiate()
	self.add_child(newToken)
	newToken.playerID = 2
	newToken.setColor()
	newToken.global_position = self.global_position
	print("Giving enemy Goblin Fighter")
	
func spawnWarriorSquire():
	var newToken = warriorSquire.instantiate()
	self.add_child(newToken)
	newToken.playerID = 2
	newToken.setColor()
	newToken.global_position = self.global_position
	print("Giving enemy warrior Squire")
	
func spawnElfArcher():
	var newToken = elfArcher.instantiate()
	self.add_child(newToken)
	newToken.playerID = 2
	newToken.setColor()
	newToken.global_position = self.global_position
	print("Giving enemy Elf Archer")
	
func spawnMageAlchemist():
	var newToken = mageAlchemist.instantiate()
	self.add_child(newToken)
	newToken.playerID = 2
	newToken.setColor()
	newToken.global_position = self.global_position
	print("Giving enemy Mage Alchemist")
	
func spawnUndeadSkeleton():
	var newToken = undeadSkeleton.instantiate()
	self.add_child(newToken)
	newToken.playerID = 2
	newToken.setColor()
	newToken.global_position = self.global_position
	print("Giving enemy Undead Skeleton")
	
func spawnHumanAcolyte():
	var newToken = humanAcolyte.instantiate()
	self.add_child(newToken)
	newToken.playerID = 2
	newToken.setColor()
	newToken.global_position = self.global_position
	print("Giving enemy human acolyte")
	
func spawnOrcZealot():
	var newToken = orcZealot.instantiate()
	self.add_child(newToken)
	newToken.playerID = 2
	newToken.setColor()
	newToken.global_position = self.global_position
	print("Giving enemy Orc Zealot")
	
func spawnGoblinSpearman():
	var newToken = goblinSpearman.instantiate()
	self.add_child(newToken)
	newToken.playerID = 2
	newToken.setColor()
	newToken.global_position = self.global_position
	print("Giving enemy goblin spearman")
	
func spawnWarriorKnight():
	var newToken = warriorKnight.instantiate()
	self.add_child(newToken)
	newToken.playerID = 2
	newToken.setColor()
	newToken.global_position = self.global_position
	print("Giving enemy warrior knight")
	
func spawnElfMercenary():
	var newToken = elfMercenary.instantiate()
	self.add_child(newToken)
	newToken.playerID = 2
	newToken.setColor()
	newToken.global_position = self.global_position
	print("Giving enemy elf mercenary")
	
func spawnMageSpellSlinger():
	var newToken = mageSpellSlinger.instantiate()
	self.add_child(newToken)
	newToken.playerID = 2
	newToken.setColor()
	newToken.global_position = self.global_position
	print("Giving enemy mage spell slinger")
	
func spawnUndeadWraith():
	var newToken = undeadWraith.instantiate()
	self.add_child(newToken)
	newToken.playerID = 2
	newToken.setColor()
	newToken.global_position = self.global_position
	print("Giving enemy undead wraith")
	
func spawnHumanMonk():
	var newToken = warriorFootman.instantiate()
	self.add_child(newToken)
	newToken.playerID = 2
	newToken.setColor()
	newToken.global_position = self.global_position
	print("Giving enemy human monk")
	
func spawnOrcShaman():
	var newToken = orcShaman.instantiate()
	self.add_child(newToken)
	newToken.playerID = 2
	newToken.setColor()
	newToken.global_position = self.global_position
	print("Giving enemy orc shaman")
	
func spawnGoblinShaman():
	var newToken = warriorFootman.instantiate()
	self.add_child(newToken)
	newToken.playerID = 2
	newToken.setColor()
	newToken.global_position = self.global_position
	print("Giving enemy goblin shaman")
	
func spawnWarriorChallenger():
	var newToken = warriorChallenger.instantiate()
	self.add_child(newToken)
	newToken.playerID = 2
	newToken.setColor()
	newToken.global_position = self.global_position
	print("Giving enemy warrior challenger")
	
func spawnElfAssassin():
	var newToken = elfAssassin.instantiate()
	self.add_child(newToken)
	newToken.playerID = 2
	newToken.setColor()
	newToken.global_position = self.global_position
	print("Giving enemy elf Assassin")
	
func spawnMageSorcerer():
	var newToken = mageSorcerer.instantiate()
	self.add_child(newToken)
	newToken.playerID = 2
	newToken.setColor()
	newToken.global_position = self.global_position
	print("Giving enemy mage sorcerer")
	
func spawnUndeadNecromancer():
	var newToken = undeadNecromancer.instantiate()
	self.add_child(newToken)
	newToken.playerID = 2
	newToken.setColor()
	newToken.global_position = self.global_position
	print("Giving enemy undead necromancer")
	
func spawnHumanDruid():
	var newToken = humanDruid.instantiate()
	self.add_child(newToken)
	newToken.playerID = 2
	newToken.setColor()
	newToken.global_position = self.global_position
	print("Giving enemy human druid")
	
func spawnOrcSkirmisher():
	var newToken = orcSkirmisher.instantiate()
	self.add_child(newToken)
	newToken.playerID = 2
	newToken.setColor()
	newToken.global_position = self.global_position
	print("Giving enemy orc Skirmisher")
	
func spawnGoblinKing():
	var newToken = goblinKing.instantiate()
	self.add_child(newToken)
	newToken.playerID = 2
	newToken.setColor()
	newToken.global_position = self.global_position
	print("Giving enemy goblin king")
