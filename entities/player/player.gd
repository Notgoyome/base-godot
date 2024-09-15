extends CharacterBody2D

class_name Player

# movement
@export var acceleration = 1500
@export var friction = 1500
@export var max_speed = 200
var can_move = true
var has_acceleration = true
var has_friction = true
var is_moving = false

# jump
var jump_height: float = 64
@export var jump_time: float = 0.3
@export var fall_time: float = 0.4
var jump_velocity: float = (2 * jump_height) / jump_time * -1
var peak_velocity: float = (2 * jump_height) / (jump_time * jump_time)
var fall_velocity: float = (2 * jump_height) / (fall_time * fall_time)
var can_jump = true
var has_gravity = true
var is_falling = false
# animation
@onready var animated_sprite: AnimatedSprite2D = $Animation

#jump buffer
@onready var jump_buffer : JumpBufferComponent = $JumpBufferComponent

# Main physics process
func _physics_process(delta: float) -> void:
	var input_vector = get_input_vector()
	update_sprite_direction(input_vector)
	apply_movement(delta, input_vector)
	handle_jump()
	apply_gravity(delta)
	move_and_slide()

# Handle input direction
func get_input_vector() -> Vector2:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	return input_vector

# Update the sprite direction based on movement
func update_sprite_direction(input_vector: Vector2) -> void:
	if input_vector.x < 0:
		animated_sprite.flip_h = true
	elif input_vector.x > 0:
		animated_sprite.flip_h = false

# Apply movement acceleration or friction
func apply_movement(delta: float, input_vector: Vector2) -> void:
	if input_vector != Vector2.ZERO and can_move and has_acceleration:
		velocity.x = velocity.move_toward(input_vector * max_speed, acceleration * delta).x
		is_moving = true
	elif input_vector == Vector2.ZERO and has_friction:
		is_moving = false
		velocity.x = velocity.move_toward(Vector2.ZERO, friction * delta).x

# Handle jumping logic
func handle_jump() -> void:
	if can_jump and jump_buffer.jump_requested:
		velocity.y = jump_velocity

# Apply gravity
func apply_gravity(delta: float) -> void:
	if has_gravity:
		velocity.y += get_self_gravity() * delta

# Get the current gravity based on the vertical velocity
func get_self_gravity() -> float:
	if velocity.y < 0:
		is_falling = false
		return peak_velocity
	else:
		is_falling = true
		return fall_velocity