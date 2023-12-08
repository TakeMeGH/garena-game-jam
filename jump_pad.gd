extends Node2D

var area : Area2D
@export var jump_height = 3

func _ready():
	area = get_child(1)

func _physics_process(delta):
	if(len(area.get_overlapping_bodies()) > 0):
		var body : Node2D = area.get_overlapping_bodies()[0].force_jump(jump_height)
		# body.get_script().force_jump(jump_height)
