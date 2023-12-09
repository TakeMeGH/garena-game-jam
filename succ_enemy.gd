extends Node2D

var succ_area : Area2D

func _ready():
	succ_area = get_child(0).get_child(2)
	
func _physics_process(delta):
	if(len(succ_area.get_overlapping_bodies()) > 0):
		await succ_area.get_overlapping_bodies()[0].manip_force(position, -100)
	pass
