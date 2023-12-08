extends Node2D
class_name Food
@onready var interaction_area : InteractionArea = $interaction_area

signal food_interact

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact(body):
	emit_signal("food_interact")
	queue_free()
