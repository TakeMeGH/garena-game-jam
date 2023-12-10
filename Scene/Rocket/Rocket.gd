extends Node2D

@onready var rocket_sprite : Sprite2D = $Sprite2D
@export var load_path : Array[String]
@onready var animation_player : AnimationPlayer = $AnimationPlayer
var current_level = -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(TownHall.current_level > 1 && current_level != TownHall.current_level - 2):
		var path = load_path[TownHall.current_level -2]
		rocket_sprite.texture = load(path)
		print("kepangil", path)
		current_level = TownHall.current_level - 2
		rocket_sprite.show()
	if(TownHall.current_level <= 1):
		rocket_sprite.hide()
