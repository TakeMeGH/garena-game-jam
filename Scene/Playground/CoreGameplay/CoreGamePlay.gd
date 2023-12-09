extends Node2D

@onready var main_character : MainCharacter = $MainCharacter
@onready var spawner : Spawner  = $spawner
@onready var sleep : sleep = $sleep
@export var hungry_random_range_min : float
@export var hungry_random_range_max : float
@export var hungry_base_value : float
@export var hungry_reduction_after_sleep : float
@onready var progress_bar : TextureProgressBar = $HungerBar/TextureProgressBar

var rng = RandomNumberGenerator.new()

func _ready():
	sleep.sleep_interact_in.connect(_sleep_interact_in)
	sleep.sleep_interact_out.connect(_sleep_interact_out)
	main_character.start_hungry_timer()
	spawner.spawn_food(3)
	sleep.interact = Callable(self, "_on_sleep_interact")

func  _process(delta):
	update_progress_bar()

func _on_main_character_hungry_timer_timeout():
	#ded
#	show_upgrade()
	pass

func _on_spawner_got_food():
	main_character.add_hungry_timer(get_hungry_value())
	
func get_hungry_value():
	return rng.randf_range(hungry_random_range_min, hungry_random_range_max) + hungry_base_value

func update_progress_bar():
	progress_bar.value = main_character.get_time_left() / main_character.max_wait_time

func _sleep_interact_in():
	main_character.enable_input(false)
	main_character.character_movement.slow_down()
	main_character.hungry_timer.paused = true

func _sleep_interact_out():
	main_character.hungry_timer.paused = false
	main_character.enable_input(true)


func _on_sleep_interact():
	main_character.add_hungry_timer(-hungry_reduction_after_sleep)
	spawner.reset_spanwer()
	spawner.spawn_food(3)


