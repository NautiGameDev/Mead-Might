extends CanvasLayer

@onready var introduction_cat = $IntroductionCat
@onready var basics_cat = $BasicsCat
@onready var objectives_cat = $ObjectivesCat
@onready var board_cat = $BoardCat
@onready var classes_cat = $ClassesCat
@onready var controls_cat = $ControlsCat
@onready var side_quests_cat = $SideQuestsCat
@onready var summary_cat = $SummaryCat

@onready var warriors = $ClassesCat/Classes/Warriors
@onready var assassins = $ClassesCat/Classes/Assassins
@onready var undead = $ClassesCat/Classes/Undead
@onready var orcs = $ClassesCat/Classes/Orcs
@onready var goblins = $ClassesCat/Classes/Goblins
@onready var mages = $ClassesCat/Classes/Mages
@onready var healers = $ClassesCat/Classes/Healers

@onready var page = $page


func _process(delta):
	if self.visible == false:
		introduction_cat.visible = true
		basics_cat.visible = false
		objectives_cat.visible = false
		board_cat.visible = false
		classes_cat.visible = false
		controls_cat.visible = false
		side_quests_cat.visible = false
		summary_cat.visible = false


func hideall():
	introduction_cat.visible = false
	basics_cat.visible = false
	objectives_cat.visible = false
	board_cat.visible = false
	classes_cat.visible = false
	controls_cat.visible = false
	side_quests_cat.visible = false
	summary_cat.visible = false
	page.play()
	
func hideClasses():
	warriors.visible = false
	undead.visible = false
	orcs.visible = false
	assassins.visible = false
	goblins.visible = false
	mages.visible = false
	healers.visible = false


func _on_welcome_button_button_up():
	hideall()
	introduction_cat.visible = true


func _on_basics_button_button_up():
	hideall()
	basics_cat.visible = true


func _on_objectives_button_button_up():
	hideall()
	objectives_cat.visible = true


func _on_board_button_button_up():
	hideall()
	board_cat.visible = true


func _on_classes_button_button_up():
	hideall()
	classes_cat.visible = true


func _on_side_quests_button_button_up():
	hideall()
	side_quests_cat.visible = true


func _on_controls_button_button_up():
	hideall()
	controls_cat.visible = true


func _on_summary_button_button_up():
	hideall()
	summary_cat.visible = true


func _on_warrior_butt_button_up():
	hideClasses()
	warriors.visible = true


func _on_undead_butt_button_up():
	hideClasses()
	undead.visible = true


func _on_orc_butt_button_up():
	hideClasses()
	orcs.visible = true


func _on_assassin_butt_button_up():
	hideClasses()
	assassins.visible = true


func _on_mages_butt_button_up():
	hideClasses()
	mages.visible = true


func _on_goblins_butt_button_up():
	hideClasses()
	goblins.visible = true


func _on_healers_butt_button_up():
	hideClasses()
	healers.visible = true
