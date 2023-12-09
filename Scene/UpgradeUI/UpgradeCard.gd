extends PanelContainer
@export var icon : TextureRect
@export var nama : Label
@export var description : Label
@export var effect : Label
@export var gold : Label

signal selected

func _ready():
	pass # Replace with function body.

func set_info(info : AbilityUpgrade):
	#var test_preload = preload("res://Assets/icon.svg")
	#icon.texture = test_preload
	nama.text = info.name
	description.text = info.description
	effect.text = info.effect
	gold.text = str(info.cost)


func _on_gui_input(event):
	if event.is_action_pressed("left_click"):
		selected.emit()
