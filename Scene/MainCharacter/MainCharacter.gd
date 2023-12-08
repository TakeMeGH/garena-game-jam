extends Node2D

@onready var hungry_timer = $HungryTimer
@export var max_wait_time : float = 10;

signal hungry_timer_timeout

func _ready():
	start_hungry_timer(max_wait_time)

func get_time_left():
	return hungry_timer.time_left

func start_hungry_timer(set_time = -1):
	hungry_timer.start(set_time)

func set_max_wait_time(set_time : float):
	max_wait_time = set_time

func add_hungry_timer(add_time):
	start_hungry_timer(min(hungry_timer.time_left + add_time, max_wait_time))

func _on_hungry_timer_timeout():
	emit_signal("hungry_timer_timeout")
