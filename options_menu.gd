extends CanvasLayer

@onready var master_slider = $SheetBackground/SoundNode/MasterVolume/MasterSlider
@onready var music_slider = $SheetBackground/SoundNode/MusicVolume/MusicSlider
@onready var ambiance_slider = $SheetBackground/SoundNode/AmbianceVolume/AmbianceSlider
@onready var sfx_slider = $SheetBackground/SoundNode/SFXVolume/SFXSlider


@onready var master = $SheetBackground/SoundNode/MasterVolume/Master
@onready var music = $SheetBackground/SoundNode/MusicVolume/Music
@onready var ambiance = $SheetBackground/SoundNode/AmbianceVolume/Ambiance
@onready var sfx = $SheetBackground/SoundNode/SFXVolume/SFXLabel2

@onready var menu_click = $menuClick
@onready var tick = $tick

@onready var fogbutton = $SheetBackground/GraphicsNode/FogEnabled/FogButton
@onready var shadowsbutton = $SheetBackground/GraphicsNode/ShadowsEnabled/ShadowsButton


func _ready():
	master_slider.value = Globals.volumeMaster
	master.text = str(Globals.volumeMaster / 5)
	music_slider.value = Globals.volumeMusic
	music.text = str(Globals.volumeMusic / 5)
	ambiance_slider.value = Globals.volumeAmbiance
	ambiance.text = str(Globals.volumeAmbiance / 5)
	sfx_slider.value = Globals.volumeSFX
	sfx.text = str(Globals.volumeSFX / 5)
	
	if Globals.volumetricFog == true:
		fogbutton.text = "true"
	elif Globals.volumetricFog == false:
		fogbutton.text = "false"
	
	if Globals.shadows == true:
		shadowsbutton.text = "true"
	elif Globals.shadows == false:
		shadowsbutton.text = "false"

func _on_master_slider_value_changed(value):
	var sfx_index= AudioServer.get_bus_index("Master")
	var volume = 0 + ((value - 100) * 0.5)
	AudioServer.set_bus_volume_db(sfx_index, volume)
	master.text = str(value / 5)
	tick.play()
	Globals.volumeMaster = value


func _on_music_slider_value_changed(value):
	var sfx_index= AudioServer.get_bus_index("Music")
	var volume = 0 + ((value - 100) * 0.5)
	AudioServer.set_bus_volume_db(sfx_index, volume)
	music.text = str(value / 5)
	tick.play()
	Globals.volumeMusic = value

func _on_ambiance_slider_value_changed(value):
	var sfx_index= AudioServer.get_bus_index("Ambiance")
	var volume = 0 + ((value - 100) * 0.5)
	AudioServer.set_bus_volume_db(sfx_index, volume)
	ambiance.text = str(value / 5)
	tick.play()
	Globals.volumeAmbiance = value


func _on_sfx_slider_value_changed(value):
	var sfx_index= AudioServer.get_bus_index("Effects")
	var volume = 0 + ((value - 100) * 0.5)
	AudioServer.set_bus_volume_db(sfx_index, volume)
	sfx.text = str(value / 5)
	tick.play()
	Globals.volumeSFX = value


func _on_button_button_up():
	self.visible = false
	menu_click.play()


func _on_fog_button_button_up():
	if Globals.volumetricFog == true:
		fogbutton.text = "False"
		Globals.volumetricFog = false
	elif Globals.volumetricFog == false:
		fogbutton.text = "True"
		Globals.volumetricFog = true
		
	tick.play()


func _on_shadows_button_button_up():
	if Globals.shadows == true:
		shadowsbutton.text = "False"
		Globals.shadows = false
	elif Globals.shadows == false:
		shadowsbutton.text = "True"
		Globals.shadows = true
		
	tick.play()
