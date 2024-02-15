extends CharacterBody2D
class_name Player

@export var move_speed : float = 100.0
@export var air_jumps_total : int = 0
var air_jumps_current : int = air_jumps_total
var can_move : bool = true

@export var jump_height : float = 100
@export var jump_time_to_peak : float = 0.5
@export var jump_time_to_descent : float = 0.30

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(delta):
	pass

func _physics_process(delta):
	velocity.y += get_gravity() * delta
	var moving_input = Input.get_axis("move_left", "move_right")
	var grounded = is_on_floor()
	var croak_input = Input.is_action_pressed("croak")

	
	if Input.is_action_pressed("jump") && can_move:
		if grounded:
			jump()
		if air_jumps_current > 0 and not grounded:
			air_jump()
	if grounded:
		if can_move:
			move(moving_input)
		croak(croak_input)
		
	move_and_slide()
	update_animations()

func get_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity
	
func get_horizontal_velocity() -> float:
	var horizontal := 0.0
	if Input.is_action_pressed("move_left"):
		horizontal -= 1.0
		$AnimatedSprite2D.flip_h = true
	if Input.is_action_pressed("move_right"):
		horizontal += 1.0
		$AnimatedSprite2D.flip_h = false
	return horizontal
	
func jump():
	$Jump.play()
	velocity.x = get_horizontal_velocity() * move_speed
	air_jumps_current = air_jumps_total
	velocity.y = jump_velocity

func air_jump():
	$Jump.play()
	velocity.x = get_horizontal_velocity() * move_speed
	air_jumps_current -= 1
	velocity.y = jump_velocity

func move(moving_input):
	if moving_input:
		velocity.x = get_horizontal_velocity() * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed / 10)

func croak(croak_input):
	#play croak sound
	if croak_input:
		stop_moving()
		$AnimatedSprite2D.play("croak")
		await $AnimatedSprite2D.animation_finished
		can_move = true
	
func die():
	print("dying")
	stop_moving()
	$AnimatedSprite2D.play("death")
	await $AnimatedSprite2D.animation_finished
	$CollisionShape2D.set_deferred("disabled", true)
	#get_tree().reload_current_scene()	
	
func stop_moving():
	can_move = false
	velocity.x = 0.0
	
func update_animations():
	if can_move:
		if is_on_floor():
			if velocity.x == 0.0:
				$AnimatedSprite2D.play("idle")
			else:
				$AnimatedSprite2D.play("walk")
		else:
			if velocity.y < 0:
				$AnimatedSprite2D.play("jump")
			if velocity.y > 550:
				$AnimatedSprite2D.play("jump_land")
