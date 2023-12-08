extends CharacterBody2D

@export var speed = 400
@export var gravity = 40
@export var jump = 800

func get_input():
	var input_direction = Input.get_axis("left", "right")
	velocity.x = input_direction * speed

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 800:
			velocity.y = 800
		print(velocity.y)
		print(global_position)

	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = -jump
	
	get_input()
	move_and_slide()
