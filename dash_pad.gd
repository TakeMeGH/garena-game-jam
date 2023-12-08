extends Node2D

var area : Area2D
@export var dash_speed = 800

func _ready():
	area = get_child(1)

func _physics_process(delta):
	if(len(area.get_overlapping_bodies()) > 0):
		var body : Node2D = area.get_overlapping_bodies()[0].force_dash(dash_speed)
		# body.get_script().force_jump(jump_height)
