extends Node2D

@export var player : Node2D
@export var bullet : PackedScene
var this_controller : CharacterBody2D
var bullet_spawn : Node2D
@export var speed : float

func _ready():
	this_controller = get_child(0)
	bullet_spawn = get_child(0).get_child(0)
	activate()

func _physics_process(delta):
	this_controller.move_and_slide()
	#print(player_dist())
	#if(player_dist() < 500):
	#	await activate()
	
func player_dir():
	var ret = (player.get_child(0).global_position - this_controller.global_position).normalized()
	ret.y = 0
	return ret
	
func player_dist():
	var ret = player.get_child(0).global_position.distance_to(this_controller.global_position)
	return ret
	
func shoot():
	var bul = bullet.instantiate()
	get_parent().add_child(bul)
	bul = get_parent().get_node("Bullet")
	bul.global_position = bullet_spawn.global_position
	bul.dir_vec = ((player.get_child(0).global_position - bul.get_child(0).global_position).normalized() * 50)
	# print("Shoot!")
	
func stop():
	this_controller.velocity = Vector2(0,0)
	
func activate():
	if player_dist() < 800:
		stop()
		await get_tree().create_timer(0.1).timeout
		shoot()
		await get_tree().create_timer(1).timeout
		stop()
		activate()
	else:
		await get_tree().create_timer(0.01).timeout
		var dir = player_dir()
		this_controller.velocity = player_dir() * speed
		activate()
