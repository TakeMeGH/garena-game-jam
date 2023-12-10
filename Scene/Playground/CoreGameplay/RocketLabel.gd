extends Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = str(TownHall.current_level-1) + " / " + str(len(TownHall.list_cost))
