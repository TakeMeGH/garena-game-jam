extends Node2D

var area : Area2D
var sprite : Sprite2D
@export var push_force = 800
var enable : bool = false
@onready var anim : AnimationPlayer = $RigidBody2D/AnimationPlayer

func _ready():
	area = get_child(0).get_child(2)
	sprite = get_child(0).get_child(0)
	sprite.visible = true
	anim.play("idle")

func _physics_process(delta):
	#print(len(area.get_overlapping_bodies())
	if(len(area.get_overlapping_bodies()) > 0) && !enable:
		print("Tripped!")
		anim.play("landmine")
		await area.get_overlapping_bodies()[0].force_push(position - Vector2(0,-100), 1000)
		sprite.visible = true
		enable = true
		surprise()
		
func surprise():
	await get_tree().create_timer(1.6).timeout
	get_parent().remove_child(self)
