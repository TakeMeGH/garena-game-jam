extends Area2D
class_name InteractionArea


@export var action_name: String = "interact"

var interact: Callable = func():
	pass

func _on_body_entered(body):
	await interact.call(body)
