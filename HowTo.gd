extends CanvasLayer

@onready var instructions = $Panel/Instructions

func _process(delta):
	if self.visible == true:
		instructions.visible = true
		
		if Input.is_action_just_pressed("pause"):
			self.visible = false
	else:
		instructions.visible = false


func _on_close_button_button_up():
	self.visible = false
