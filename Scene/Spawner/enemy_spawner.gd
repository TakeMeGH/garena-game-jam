extends Node2D
class_name EnemySpawner

@export var enemy_list : Array[PackedScene]
var position_list : Array[Node2D]

var rng = RandomNumberGenerator.new()
var avail_position = []
var spawned_object = []
signal got_food

func _ready():
	reset_spanwer()
	var location_enemy = $"../PositionsEnemy"
	for _i in location_enemy.get_children():
		position_list.append(_i)

		
func spawn_enemy(number_of_enemy):
	for i in range(number_of_enemy):
		if(len(avail_position) == 0):
			break
		var get_index : int = rng.randi_range(0, avail_position.size()-1)
		var random_position = position_list[avail_position[get_index]]
		avail_position.remove_at(get_index)
		
		var get_index_enemy = rng.randi_range(0, enemy_list.size() - 1)
		var created_enemy = enemy_list[get_index_enemy].instantiate()
		add_child(created_enemy)
		
		created_enemy.global_position = random_position.global_position
		spawned_object.append(created_enemy)


func reset_spanwer():
	for i in range(spawned_object.size()):
		if(is_instance_valid(spawned_object[i])):
			spawned_object[i].queue_free()
			
	spawned_object.clear()
	avail_position.clear()
	for i in range(len(position_list)):
		avail_position.append(i)
