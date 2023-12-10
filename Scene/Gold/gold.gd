extends Node2D
class_name GoldObject
@onready var interaction_area : InteractionArea = $interaction_area

signal gold_interact

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact(body):
	if body.is_in_group("player"):
		Gold.add_gold()
		queue_free()
