extends Node2D

@export var player : Node2D
@export var bullet : PackedScene
var this_controller : CharacterBody2D
var bullet_spawn : Node2D
@export var speed : float
@onready var ground_check = $CharacterBody2D/RayCast2D
@onready var sprite : Sprite2D = $CharacterBody2D/Icon
@onready var anim = $CharacterBody2D/AnimationPlayer

func _ready():
	this_controller = get_child(0)
	bullet_spawn = get_child(0).get_child(0)
	anim.play("static")
	if(len(get_tree().get_nodes_in_group("player")) > 0):
		player = get_tree().get_nodes_in_group("player")[0]
	activate()

func _process(delta):
	if this_controller.velocity.x > 0:
		sprite.flip_h = true
	elif this_controller.velocity.x < 0:
		sprite.flip_h = false

func _physics_process(delta):
	this_controller.move_and_slide()

	
func player_dir():
	if(player == null || player.get_child(0) == null):
		return this_controller.global_position.normalized()
	var ret = (player.get_child(0).global_position - this_controller.global_position).normalized()
	
	if ground_check.is_colliding() && ret.y > 0:
		ret.y = 0
	return ret
	
func player_dist():
	if(player == null || player.get_child(0) == null):
		return 1e9
	var ret = player.get_child(0).global_position.distance_to(this_controller.global_position)
	return ret
	
func shoot():
	if(player == null):
		return
	var bul = bullet.instantiate()
	get_parent().add_child(bul)
	bul = get_parent().get_node("Bullet")
	bul.global_position = bullet_spawn.global_position
	bul.dir_vec = ((player.get_child(0).global_position - bul.get_child(0).global_position).normalized() * 50)
	# print("Shoot!")
	
func stop():
	this_controller.velocity = Vector2(0,0)
	
func readjust():
	var dist = ground_check.get_collision_point().distance_to(this_controller.global_position)
	if dist < 500:
		this_controller.velocity = Vector2.UP * speed
	
func activate():
	if player_dist() < 800:
		stop()
		anim.play("attack")
		await get_tree().create_timer(0.8).timeout
		shoot()
		await get_tree().create_timer(1).timeout
		readjust()
		await get_tree().create_timer(0.5).timeout
		stop()
		activate()
	else:
		anim.play("static")
		await get_tree().create_timer(0.01).timeout
		var dir = player_dir()
		this_controller.velocity = player_dir() * speed
		activate()
		
		
