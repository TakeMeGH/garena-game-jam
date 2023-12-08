extends StaticBody2D

@onready var interaction_area : InteractionArea = $interaction_area


func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact():
	queue_free()
