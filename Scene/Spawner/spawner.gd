extends Node2D
class_name Spawner
@export var position_list : Array[Node2D]
@export var food_scene : PackedScene

var avail_position = []
var spawned_object = []
signal got_food

var rng = RandomNumberGenerator.new()

func _ready():
	reset_spanwer()

func spawn_food(number_of_food):
	for i in range(number_of_food):
		var get_index : int = rng.randi_range(0, avail_position.size()-1)
		var random_position = position_list[avail_position[get_index]]
		avail_position.remove_at(get_index)
		
		var created_food : Food = food_scene.instantiate()
		created_food.food_interact.connect(retrieve_food)
		add_child(created_food)
		
		created_food.global_position = random_position.global_position
		spawned_object.append(created_food)

func retrieve_food():
	emit_signal("got_food")

func reset_spanwer():
	for i in range(spawned_object.size()):
		if(is_instance_valid(spawned_object[i])):
			spawned_object[i].queue_free()
			
	spawned_object.clear()
	avail_position.clear()
	for i in range(len(position_list)):
		avail_position.append(i)
