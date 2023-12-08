extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var label = $InteractionManagerLabel

const base_text = "[E] to "

var actives_areas = []
var can_interact = true


func register_area(area : InteractionArea):
	actives_areas.push_back(area)
	
func unregister_area(area : InteractionArea):
	var index = actives_areas.find(area)
	if index != -1:
		actives_areas.remove_at(index)
		
func _process(delta):
	if actives_areas.size() > 0 && can_interact:
		actives_areas.sort_custom(_sort_by_distance_to_player)
		label.text = base_text + actives_areas[0].action_name
		label.global_position = actives_areas[0].global_position
		label.show()
	elif label != null:
		label.hide()
		
func _sort_by_distance_to_player(area1, area2):
	var area1_to_player = player.global_position.distance_to(area1.global_position)
	var area2_to_player = player.global_position.distance_to(area2.global_position)
	return area1_to_player < area2_to_player
	
func _input(event):
	if(event.is_action_pressed("interact") && can_interact):
		if(actives_areas.size() > 0):
			can_interact = false
			label.hide()
			
			await actives_areas[0].interact.call()
			
			can_interact = true
