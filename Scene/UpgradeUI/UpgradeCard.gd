extends PanelContainer
@export var icon : TextureRect
@export var nama : Label
@export var description : Label
@export var effect : Label
@export var gold : Label

signal selected

var is_enable = true
@onready var margin_container : MarginContainer = $MarginContainer

func _ready():
	pass # Replace with function body.

func set_info(info : AbilityUpgrade):
	icon.texture = load(info.icon_path)
	nama.text = info.name
	description.text = info.description
	effect.text = info.effect
	gold.text = str(info.cost)
	
	var color = margin_container.modulate
	if(info.cost > Gold.gold):
		is_enable = false
		color.a = 0.3
		margin_container.modulate = color


	else:
		is_enable = true
		color.a = 1
		margin_container.modulate = color


func _on_gui_input(event):
	if event.is_action_pressed("left_click") && is_enable:
		selected.emit()
