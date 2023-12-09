extends Node2D
class_name sleep

@onready var sleep_transsition = $CanvasLayer
var on_area = false
var can_interact = true

signal sleep_interact_in
signal sleep_interact_out

var interact: Callable = func():
	pass


func _on_area_2d_area_entered(area):
	on_area = true


func _on_area_2d_area_exited(area):
	on_area = false
	
func _input(event):
	if(event.is_action_pressed("interact") && can_interact):
		emit_signal("sleep_interact_in")
		can_interact = false
		await sleep_transsition.sleep_transition_enter()
		interact.call()
		await sleep_transsition.sleep_transition_exit()
		can_interact = true
		emit_signal("sleep_interact_out")
