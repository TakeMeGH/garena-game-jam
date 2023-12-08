extends Node2D

@onready var main_character = $MainCharacter
@onready var spawner : Spawner  = $spawner

@export var hungry_random_range_min : float
@export var hungry_random_range_max : float
@export var hungry_base_value : float
@onready var progress_bar : TextureProgressBar = $CanvasLayer/TextureProgressBar

var rng = RandomNumberGenerator.new()

func _ready():
	main_character.start_hungry_timer()
	spawner.spawn_food(3)

func  _process(delta):
	update_progress_bar()

func _on_main_character_hungry_timer_timeout():
	pass

func _on_spawner_got_food():
	main_character.add_hungry_timer(get_hungry_value())
	
func get_hungry_value():
	return rng.randf_range(hungry_random_range_min, hungry_random_range_max) + hungry_base_value

func update_progress_bar():
	progress_bar.value = main_character.get_time_left() / main_character.max_wait_time
	print(main_character.get_time_left() / main_character.max_wait_time)
