extends CharacterBody2D

@export var speed = 700
@export var max_speed = 2000
@export var gravity = 40
@export var jump = 800

var curr_speed : float= 0
var speed_lerp : float = 0
var jump_amount = 2
var can_move : bool = true

func get_input(delta):
	var input_direction = Input.get_axis("left", "right")
	
	# if !Input.is_action_pressed("slide"):
	# 	curr_speed = input_direction * speed
	if Input.is_action_just_pressed("slide"):
		curr_speed += input_direction * speed * 2
	
	if !Input.is_action_pressed("slide"):
		if !is_on_floor():
			if(input_direction != 0):
				curr_speed += input_direction * speed * 0.5
				curr_speed = min(curr_speed, speed)
				curr_speed = max(curr_speed, -speed)
			else:
				curr_speed -= velocity.normalized().x * 10
		else:
			curr_speed = input_direction * speed
		
	velocity.x = curr_speed

func _physics_process(delta):
	if can_move:
		moving(delta)
	
	move_and_slide()
	
func moving(delta):
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
	
func force_jump(jump_force):
	velocity.y = -jump_force * jump

func force_dash(dash_force):
	if(curr_speed != 0):
		curr_speed += (curr_speed / abs(curr_speed)) * dash_force
		print(curr_speed)

func slow_down():
	curr_speed = 0
	velocity = Vector2(0,0)
