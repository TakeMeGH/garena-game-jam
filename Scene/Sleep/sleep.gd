extends Node2D
class_name sleep

@onready var sleep_transsition = $CanvasLayer
@onready var text_label = $Label
var on_area = false
var can_interact = true

signal sleep_interact_in
signal sleep_interact_out

var interact: Callable = func():
	pass

func _ready():
	on_area = false
	
func _input(event):
	if(event.is_action_pressed("interact") && can_interact && on_area):
		emit_signal("sleep_interact_in")
		can_interact = false
		await sleep_transsition.sleep_transition_enter()
		interact.call()
		await sleep_transsition.sleep_transition_exit()
		can_interact = true
		emit_signal("sleep_interact_out")

func _process(delta):
	if(on_area && can_interact):
		text_label.text = "[F] To Sleep"
		text_label.show()
	else:
		text_label.hide()

func _on_interaction_area_body_entered(body):
	if body.is_in_group("player"):
		on_area = true


func _on_interaction_area_body_exited(body):
	if body.is_in_group("player"):
		on_area = false
