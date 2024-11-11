extends Sprite3D

@onready var unit_name = $SubViewport/data/name
@onready var attack_stat = $SubViewport/data/attackStat
@onready var health_stat = $SubViewport/data/healthStat

func updateStats(name, attack, health):
	unit_name.text = name
	attack_stat.text = str(attack)
	health_stat.text = str(health)
