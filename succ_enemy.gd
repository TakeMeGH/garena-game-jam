extends Node2D

var succ_area : Area2D
var is_succ = false
@onready var anim : AnimationPlayer = $CharacterBody2D/AnimationPlayer

func _ready():
	succ_area = get_child(0).get_child(2)
	anim.play("idle")
	
func _physics_process(delta):
	if(len(succ_area.get_overlapping_bodies()) > 0):
		anim.play("succ")
		#await get_tree().create_timer(0.5).timeout
		anim.play("curr_succ")
		is_succ = true
		succ_area.get_overlapping_bodies()[0].manip_force(position, -100)
	else:
		if is_succ:
			anim.play("finish")
			await get_tree().create_timer(0.5).timeout
			is_succ = false
		else:
			anim.play("idle")
