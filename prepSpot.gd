extends Marker3D

var hasChild = false

func receiveChild(unit):
	self.add_child(unit)
	unit.basePosition = self.global_position
	print(self.get_children())
	
func loseChild(unit):
	self.remove_child(unit)
