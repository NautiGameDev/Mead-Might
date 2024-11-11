extends Node3D

var selectedUnit = null

@onready var turn_handler = $"../turnHandler"

var playerTurn = 0
var winnerDeclared : bool = false

@onready var unitSelect = $unitSelect
@onready var unitPlace = $unitPlace



func _process(delta):
	if Input.is_action_just_pressed("rightClick") && selectedUnit != null && playerTurn == 1:
		selectedUnit.isSelected = false
		selectedUnit.particles.emitting = false
		selectedUnit = null
		unitSelect.play()

func newUnit(unit):
	if selectedUnit != null:
		selectedUnit.isSelected = false
		selectedUnit.particles.emitting = false
		
	if playerTurn == 1 && unit.playerID == 1 && winnerDeclared == false:
		selectedUnit = unit
		selectedUnit.isSelected = true
		unitSelect.play()
		
func AIUnit(unit):
	if winnerDeclared == false:
		if selectedUnit != null:
			selectedUnit.isSelected = false
			selectedUnit.particles.emitting = false
			
			
		selectedUnit = unit
		selectedUnit.isSelected = true
		unitSelect.play()
	
func cellSelected(cell, damageMod, healthMod):
	if selectedUnit != null && winnerDeclared == false:
		selectedUnit.damage += damageMod
		selectedUnit.health += healthMod
		if selectedUnit.health > 0:
			selectedUnit.basePosition = Vector3(cell.global_position.x, cell.global_position.y + 0.075, cell.global_position.z)
			selectedUnit.placed(cell)
			selectedUnit = null
			cell.hasUnit = true
		turn_handler.nextTurn()
		unitPlace.play()
