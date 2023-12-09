extends Node2D

var area : Area2D
var sprite : Sprite2D
@export var push_force = 800
var enable : bool = false

func _ready():
	area = get_child(0).get_child(2)
	sprite = get_child(0).get_child(0)
	sprite.visible = false

func _physics_process(delta):
	if(len(area.get_overlapping_bodies()) > 0) && !enable:
		await area.get_overlapping_bodies()[0].force_push(position, 1000)
		sprite.visible = true
		enable = true
		surprise()
		
func surprise():
	await get_tree().create_timer(2).timeout
	get_parent().remove_child(self)
