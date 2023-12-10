extends Node2D

@onready var main_character : MainCharacter = $MainCharacter
@onready var spawner : Spawner  = $spawner
@onready var sleep : sleep = $sleep
var base_sleep = hungry_reduction_after_sleep

@export var hungry_random_range_min : float
@export var hungry_random_range_max : float
@export var hungry_base_value : float
@export var hungry_reduction_after_sleep : float
@export var hungry_multiplier : float
@export var hungry_max_value : float

@onready var progress_bar : TextureProgressBar = $HungerBar/TextureProgressBar
@onready var upgrade_ui = $UpgradeUI
@onready var upgrade_manager = $UpgradeManager

@export var player : PackedScene

@onready var backup_camera : Camera2D = $BackupCamera
@onready var UpgradeController = $UpgradeController
@onready var enemy_spawner : EnemySpawner  = $EnemySpawner

@onready var game_music_player = $GameMusicPlayer
@onready var sleep_music_player = $SleepMusicPlayer
@onready var lose_music_player = $LoseMusicPlayer
@onready var rocket = $Rocket
var rng = RandomNumberGenerator.new()
const number_of_spawned_object = 10

var move_rocket = false

func _ready():
	game_music_player.play()
	sleep.sleep_interact_in.connect(_sleep_interact_in)
	sleep.sleep_interact_out.connect(_sleep_interact_out)
	sleep.interact = Callable(self, "_on_sleep_interact")
	
	main_character.start_hungry_timer(hungry_max_value) # start and set
	main_character.hungry_timer_timeout.connect(_on_main_character_hungry_timer_timeout)
	TownHall.end_game.connect(do_end_game_things)
	reset_resource()
	
	upgrade_ui.upgrade_selected.connect(on_upgrade_selected)

func  _process(delta):
	update_progress_bar()
	if(move_rocket):
		rocket.global_position -= Vector2(0, delta*800)
		if(rocket.global_position.y > 1920):
			get_tree().change_scene_to_file("res://Scene/FinishUI/finishUI.tscn")
			move_rocket = false
			

func _on_main_character_hungry_timer_timeout():
	backup_camera.global_position = get_tree().get_nodes_in_group("player")[0].get_child(0).global_position
	get_tree().get_nodes_in_group("player")[0].queue_free()
	backup_camera.enabled = true
	upgrade_ui.set_upgrade(upgrade_manager.get_upgrade(3))
	upgrade_ui.show()
	reset_resource()
	lose_music_player.play()
	game_music_player.stop()
	sleep_music_player.stop()
	

func _on_spawner_got_food():
	if(main_character == null):
		return
	main_character.add_hungry_timer(get_hungry_value())
	
func get_hungry_value():
	return rng.randf_range(hungry_random_range_min, hungry_random_range_max) + hungry_base_value * hungry_multiplier

func update_progress_bar():
	if(!is_instance_valid(main_character)):
		return
	progress_bar.value = main_character.get_time_left() / main_character.max_wait_time

func _sleep_interact_in():
	main_character.enable_input(false)
	main_character.character_movement.slow_down()
	main_character.hungry_timer.paused = true
	game_music_player.stop()
	sleep_music_player.play()
	


func _sleep_interact_out():
	main_character.hungry_timer.paused = false
	main_character.enable_input(true)
	sleep_music_player.stop()
	game_music_player.play()


func _on_sleep_interact():
	main_character.add_hungry_timer(-hungry_reduction_after_sleep)
	spawner.reset_spanwer()
	reset_resource()

func on_upgrade_selected(upgrade : AbilityUpgrade):
	if(upgrade != null):
		Gold.gold -= upgrade.cost
		#UpgradeController.
	upgrade_ui.hide()
	
	main_character = player.instantiate()
	Gold.gold = 0
	backup_camera.enabled = false
	add_child(main_character)
	TownHall.reset_level()
	main_character.start_hungry_timer()
	main_character.hungry_timer_timeout.connect(_on_main_character_hungry_timer_timeout)
	
	UpgradeController.set_main_character(main_character)
	UpgradeController.reset()
	
	lose_music_player.stop()
	game_music_player.play()
	sleep_music_player.stop()
	
func dream_upgrade(count):
	var temp_sleep_cost : float = base_sleep
	for i in range(count):
		temp_sleep_cost *= 85.0 / 100
	hungry_reduction_after_sleep = temp_sleep_cost

func reset_resource():
	enemy_spawner.reset_spanwer()
	enemy_spawner.spawn_enemy(4*number_of_spawned_object)
	spawner.reset_spanwer()
	spawner.spawn_food(2*number_of_spawned_object)
	spawner.spawn_gold(2*number_of_spawned_object)
	
func do_end_game_things():
	rocket.animation_player.play("TERBANG")
	move_rocket = true;
	backup_camera.enabled = true
	main_character.queue_free()
	print("WOY")
