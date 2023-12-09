extends Node2D
class_name MainCharacter

@onready var hungry_timer = $HungryTimer
@export var max_wait_time : float = 10;
@onready var character_movement : CharacterBody2D = $CharacterBody2D
@onready var sprite : Sprite2D = $CharacterBody2D/Sprite2D
var anim: AnimationPlayer
signal hungry_timer_timeout

func _ready():
	start_hungry_timer(max_wait_time)
	anim = get_child(0).get_child(3)
	anim.play("idle")
	
func _process(delta):
	if Input.get_axis("left", "right") == 1:
		sprite.flip_h = false;
		anim.play("running_player")
	elif Input.get_axis("left", "right") == -1:
		sprite.flip_h = true;
		anim.play("running_player")
	else:
		anim.play("idle")
		
	if !character_movement.is_on_floor():
		anim.play("isjumping")
		
	if abs(character_movement.velocity.x) > 750:
		anim.play("dash")
	
	pass

func get_time_left():
	return hungry_timer.time_left

func start_hungry_timer(set_time = -1):
	hungry_timer.start(set_time)

func set_max_wait_time(set_time : float):
	max_wait_time = set_time

func add_hungry_timer(add_time):
	start_hungry_timer(min(max(0.001, hungry_timer.time_left + add_time), max_wait_time))

func _on_hungry_timer_timeout():
	emit_signal("hungry_timer_timeout")
	
func enable_input(is_enable : bool):
	character_movement.can_move = is_enable
