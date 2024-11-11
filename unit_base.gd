extends StaticBody3D

var common_mat = preload("res://Scenes/Units/commonBase.tres")
var uncommon_mat = preload("res://Scenes/Units/uncommonBase.tres")
var rare_mat = preload("res://Scenes/Units/rare_mat.tres")
var legendary_mat = preload("res://Scenes/Units/legendaryBase.tres")
@onready var model = $Base/unitBase/RootNode/Cylinder

func _ready():
	var rarity = self.get_parent().rarity
	
	if rarity == 1:
		model.set_surface_override_material(0, common_mat)
	elif rarity == 2:
		model.set_surface_override_material(0, uncommon_mat)
	elif rarity == 3:
		model.set_surface_override_material(0, rare_mat)
	elif rarity == 4:
		model.set_surface_override_material(0, legendary_mat)
