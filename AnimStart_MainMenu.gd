extends AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	# Access the AnimationPlayer node
	var animation_player =$"."

	# Play the animation
	animation_player.play("sparkles")  # Replace with the actual name of your animation

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
