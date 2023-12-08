extends CharacterBody2D

@export var speed = 700
@export var max_speed = 2000
@export var gravity = 40
@export var jump = 800

var curr_speed : float= 0
var speed_lerp : float = 0
var jump_amount = 2

func get_input(delta):
	var input_direction = Input.get_axis("left", "right")
	
	# if !Input.is_action_pressed("slide"):
	# 	curr_speed = input_direction * speed
	if Input.is_action_just_pressed("slide"):
		curr_speed += input_direction * speed * 2
	
	if !Input.is_action_pressed("slide"):
		if !is_on_floor():
			if(input_direction != 0):
				curr_speed += input_direction * speed * delta
				curr_speed = min(curr_speed, max_speed)
				curr_speed = max(curr_speed, -max_speed)
			else:
				curr_speed -= velocity.normalized().x * 10
		else:
			curr_speed = input_direction * speed
		
	velocity.x = curr_speed

func _physics_process(delta):
	
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 1000:
			velocity.y = 1000
	else:
		jump_amount = 2

	if Input.is_action_pressed("slide"):
		curr_speed -= velocity.normalized().x * 20
	
	if Input.is_action_just_pressed("jump") && (is_on_floor() || jump_amount > 0):
		velocity.y = -jump
		velocity.x = Input.get_axis("left", "right") * speed
		jump_amount -= 1
	
	get_input(delta)
	move_and_slide()
	
func force_jump(jump_force):
	velocity.y = -jump_force * jump
