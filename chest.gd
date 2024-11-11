extends Node3D

var winnerID = 0
@onready var anim = $anim

@onready var chest_announcement = $ChestAnnouncement
@onready var announcement_label = $ChestAnnouncement/ChestWinner/AnnouncementLabel
@onready var unit_text = $ChestAnnouncement/ChestWinner/UnitText
@onready var chest_particle = $ChestParticle
@onready var powerup_sound = $powerupSound
@onready var chest_open = $chestOpen


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

var tokens = [warriorSquire, elfArcher, mageAlchemist, undeadSkeleton, humanAcolyte, orcZealot, goblinSpearman, warriorKnight, elfMercenary, mageSpellSlinger, undeadWraith, humanMonk, orcShaman, goblinShaman, warriorChallenger, elfAssassin, mageSorcerer, undeadNecromancer, humanDruid, orcSkirmisher, goblinKing]
var tokenName = ["Squire", "Archer", "Alchemist", "Skeleton", "Acolyte", "Zealot", "Spearman", "Knight", "Mercenary", "Spell Slinger", "Wraith", "Monk", "Orc Shaman", " Goblin Shaman", "Challenger", "Assassin", "Sorcerer", "Necromancer", "Druid", "Skirmisher", "Goblin King"]

func resolvePowerup(lastHitID):
	var randomToken = randi_range(0, 20)
	
	var newToken = tokens[randomToken].instantiate()
	if lastHitID == 1:
		var playerCollection = get_tree().get_first_node_in_group("playerCollection")
		newToken.playerID = 1
		playerCollection.add_child(newToken)
		newToken.setColor()
		newToken.basePosition = playerCollection.global_position
		var playerName = get_tree().get_first_node_in_group("player1UI").opponentName
		announcement_label.text = playerName + " wins the chest!"
		unit_text.text = tokenName[randomToken]
	elif lastHitID == 2:
		var playerCollection = get_tree().get_first_node_in_group("enemyCollection")
		newToken.playerID = 2
		playerCollection.add_child(newToken)
		newToken.setColor()
		newToken.basePosition = playerCollection.global_position
		var playerName = get_tree().get_first_node_in_group("player2UI").opponentName
		announcement_label.text = playerName + " wins the chest!"
		unit_text.text = tokenName[randomToken]
	
	powerup_sound.play()
	chest_open.play()	
	anim.play("open")
	await get_tree().create_timer(2).timeout
	anim.play("hideUI")
	self.get_parent().resolvePowerup()
	
	
