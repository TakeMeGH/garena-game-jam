extends CanvasLayer

var simultaneous_scene = preload("res://Scene/Playground/CoreGameplay/CoreGamePlay.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_exit_button_pressed():
	print("QUIT")
	get_tree().quit()



func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Scene/tutorial.tscn")
	

