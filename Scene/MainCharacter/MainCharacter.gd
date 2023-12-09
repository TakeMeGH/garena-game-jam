extends Node2D
class_name MainCharacter

@onready var hungry_timer = %HungryTimer
@export var max_wait_time : float = 10;
@onready var character_movement = $CharacterBody2D
signal hungry_timer_timeout
var base_wait_time : float

func _ready():
	start_hungry_timer(max_wait_time)
	base_wait_time = max_wait_time

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
	
func set_movement_speed(count):
	for i in range(count):
		character_movement.max_speed *= 115.0 / 100
		character_movement.speed *= 115.0 / 100

func extend_timer(count):
	var temp_wait_time : float = base_wait_time
	for i in range(count):
		temp_wait_time *= 115.0 / 100
	max_wait_time = temp_wait_time

func double_jump_enabled():
	character_movement.jump_amount = 2

#func _process(delta):
	#print(character_movement.speed, character_movement.max_speed)
