extends CanvasLayer

var rotatingLeft : bool = false
var rotatingRight : bool = false
var camera

func _ready():
	camera = get_tree().get_first_node_in_group("cameraNode")
	
func _process(delta):
	if rotatingLeft == true:
		camera.rotateLeft()
	elif rotatingRight == true:
		camera.rotateRight()

func _on_up_button_up():
	camera.moveUp()

func _on_down_button_up():
	camera.moveDown()

func _on_left_button_down():
	rotatingLeft = true

func _on_right_button_down():
	rotatingRight = true

func _on_left_button_up():
	rotatingLeft = false


func _on_right_button_up():
	rotatingRight = false
