extends Node3D

@onready var particles = $GPUParticles3D
@onready var model = $grid_cell/RootNode/Cylinder_102

@onready var white_mat = preload("res://Scenes/Units/white.tres")
@onready var orange_mat = preload("res://Scenes/Units/cellhighlight.tres")
@onready var grass_mat = preload("res://Scenes/Units/grass.tres")
@onready var water_mat = preload("res://Scenes/Units/water.tres")
@onready var sand_mat = preload("res://Scenes/Units/sand.tres")
@onready var darkGrass_mat = preload("res://Scenes/Units/darkGrass.tres")
var currentMat

var selectedUnit = null
var isHovered : bool = false
var hasUnit : bool = false
var isUsable : bool = false

var unitHandler

var damageMod = randi_range(-5, 5)
var healthMod = randi_range(-5, 5)
@onready var label = $modifier/SubViewport/Label

@export var heightmap = FastNoiseLite.new()
var heightSeed = 0
@export var terrainmap = FastNoiseLite.new()

@onready var tree1 = preload("res://Scenes/Units/tree_1.tscn")
@onready var tree2 = preload("res://Scenes/Units/tree_2.tscn")
@onready var modifier = $modifier

func _ready():
	unitHandler = get_tree().get_first_node_in_group("unitHandler")
	
func checkHeight(seed):
	heightmap.seed = seed
	terrainmap.seed = seed
	
	var globalPos = Vector2(self.global_position.x, self.global_position.z)
	
	var terrain = (terrainmap.get_noise_2dv(globalPos))
	
	if terrain > 0.1:
		model.set_surface_override_material(1, darkGrass_mat)
		currentMat = darkGrass_mat
		isUsable = true	
	
	elif terrain > -0.1:
		model.set_surface_override_material(1, grass_mat)
		currentMat = grass_mat
		isUsable = true	
	
	elif terrain > -0.25:
		model.set_surface_override_material(1, sand_mat)
		currentMat = sand_mat
		isUsable = true
	else:
		model.set_surface_override_material(1, water_mat)
		currentMat = water_mat
		hasUnit = true
		isUsable = false
		
	if terrain > 0.23:
		var randDecor = randi_range(1,2)
		
		if randDecor == 1:
			var newObj = tree1.instantiate()
			self.add_child(newObj)
			newObj.global_position = self.global_position
		elif randDecor == 2:
			var newObj = tree2.instantiate()
			self.add_child(newObj)
			newObj.global_position = self.global_position
			
		hasUnit = true
		isUsable = true
	
	
	var height = (heightmap.get_noise_2dv(globalPos) + 1)
	
	self.global_position.y = height - 0.25
	
	
	damageMod = int((height - 1) * 10)
	healthMod = int((terrain) * 10)
	
	if terrain > -0.25: 
		label.text = str(damageMod) + "/" + str(healthMod)
	else:
		label.text = ""
	
func _process(delta):
	if Input.is_action_just_pressed("leftClick") && isHovered:
		unitHandler.cellSelected(self, damageMod, healthMod)

func freeCell():
	hasUnit = false

func unitSelected(unit):
	selectedUnit = unit

func _on_area_3d_mouse_entered():
	if Globals.playing == true && hasUnit == false && unitHandler.selectedUnit && unitHandler.playerTurn == 1:
		particles.emitting = true
		isHovered = true
		model.set_surface_override_material(1, orange_mat)


func _on_area_3d_mouse_exited():
	particles.emitting = false
	isHovered = false
	model.set_surface_override_material(1, currentMat)
