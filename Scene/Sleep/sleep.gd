extends Node2D
class_name sleep

@onready var sleep_transsition = $CanvasLayer
var on_area = false
var can_interact = true

signal sleep_interact_in
signal sleep_interact_out

var interact: Callable = func():
	pass

	
func _input(event):
	if(event.is_action_pressed("interact") && can_interact && on_area):
		emit_signal("sleep_interact_in")
		can_interact = false
		await sleep_transsition.sleep_transition_enter()
		interact.call()
		await sleep_transsition.sleep_transition_exit()
		can_interact = true
		emit_signal("sleep_interact_out")


func _on_interaction_area_body_entered(body):
	on_area = true


func _on_interaction_area_body_exited(body):
	on_area = false
