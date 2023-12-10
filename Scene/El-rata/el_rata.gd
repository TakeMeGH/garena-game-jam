extends Node2D
class_name ElRata

var on_area = false
var can_interact = true

signal sleep_interact_in
signal sleep_interact_out

var interact: Callable = func():
	pass

	
func _input(event):
	if(event.is_action_pressed("interact") && can_interact && on_area):
		TownHall.pay(Gold.gold)



func _on_interaction_area_body_entered(body):
	on_area = true


func _on_interaction_area_body_exited(body):
	on_area = false
