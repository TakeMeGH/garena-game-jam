extends PanelContainer

func _input(event):
	if event.is_action_pressed("left_click"):
		get_tree().change_scene_to_file("res://Scene/MainMenuUI.tscn")
