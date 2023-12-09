extends Node2D

var sb : StaticBody2D
var dir_vec = Vector2(10,10)
var dest = false

func _ready():
	sb = get_child(0)
	destroy()

func _physics_process(delta):
	#sb.constant_linear_velocity = Vector2.UP * -10
	var col = sb.move_and_collide(dir_vec)
	# print(dir_vec)
	if col != null:
		make_damage(col)
		dest = true
		get_parent().remove_child(self)
	
	
func make_damage(player):
	if player.get_collider().get_collision_layer() == 1:
		player.get_collider().slow_down()

func destroy():
	await get_tree().create_timer(2).timeout
	if !dest:
		get_parent().remove_child(self)
