extends CharacterBody2D

@export var speed = 700
@export var max_speed = 2000
@export var gravity = 40
@export var jump = 800

var curr_speed : float= 0
var speed_lerp : float = 0

func get_input(delta):
	var input_direction = Input.get_axis("left", "right")
	
	# if !Input.is_action_pressed("slide"):
	# 	curr_speed = input_direction * speed
	if Input.is_action_just_pressed("slide"):
		curr_speed += input_direction * speed * 0.5
	
	if !Input.is_action_pressed("slide"):
		if !is_on_floor():
			#if abs(curr_speed) <= speed:
			curr_speed += input_direction * speed * delta * 2
			curr_speed = min(curr_speed, max_speed)
			curr_speed = max(curr_speed, -max_speed)
		else:
			curr_speed = input_direction * speed
		
	velocity.x = curr_speed
	
	print(velocity.x)

func _physics_process(delta):
	
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 800:
			velocity.y = 800

	if Input.is_action_pressed("slide"):
		curr_speed -= velocity.normalized().x * 10
	
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = -jump
		# velocity.x = Input.get_axis("left", "right") * speed
	
	get_input(delta)
	move_and_slide()
