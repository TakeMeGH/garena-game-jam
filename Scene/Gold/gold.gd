extends Node2D
class_name GoldObject
@onready var interaction_area : InteractionArea = $interaction_area
@onready var pickup_sound = $PickupSound

signal gold_interact

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact(body):
	pickup_sound.play()
	Gold.add_gold()
	queue_free()
