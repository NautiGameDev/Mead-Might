extends Node3D

@onready var camera = $Camera3D
@onready var top = $top


var mouse_sensitivity = 0.3

var randomStrength : float = 0.5
var shakeFade : float = 10.0

var rng = RandomNumberGenerator.new()

var shakeStrength: float = 0.0

func _input(event: InputEvent):
	if Globals.playing == true:
		
		if event is InputEventMouseMotion && Input.is_action_pressed("midbutton"):
			self.rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
			
			
		if Input.is_action_just_pressed("mWheelUp") || Input.is_action_just_pressed("up"):
			top.current = true
		if Input.is_action_just_pressed("mWheelDown") || Input.is_action_just_pressed("down"):
			camera.current = true
		if Input.is_action_pressed("left"):
			self.rotate_y(-mouse_sensitivity * .25)
		if Input.is_action_pressed("right"):
			self.rotate_y(mouse_sensitivity * .25)

func rotateLeft():
	self.rotate_y(-mouse_sensitivity * .05)
	
func rotateRight():
	self.rotate_y(mouse_sensitivity * .05)
	
func moveUp():
	top.current = true
	
func moveDown():
	camera.current = true


func _process(delta):
	if shakeStrength > 0:
		shakeStrength = lerpf(shakeStrength, 0, shakeFade * delta)
	
		camera.h_offset = randomOffset()
		camera.v_offset = randomOffset()
		top.h_offset = randomOffset()
		top.v_offset = randomOffset()

func applyShake():
	shakeStrength = randomStrength
	
func randomOffset() -> float:
	return float(rng.randf_range(-shakeStrength, shakeStrength))
