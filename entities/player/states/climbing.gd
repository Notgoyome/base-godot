extends State

@export var player: Player
var climbing = false
var tween : Tween

var keep_velocity_duration = 0.1
var keep_velocity_timer : Timer
var bool_velocity = false
var keep_velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	keep_velocity_timer = Timer.new()
	keep_velocity_timer.wait_time = keep_velocity_duration
	keep_velocity_timer.one_shot = true
	keep_velocity_timer.timeout.connect(_reset_velocity)
	add_child(keep_velocity_timer)
	pass # Replace with function body.

func _reset_velocity() -> void:
	keep_velocity = Vector2.ZERO
	bool_velocity = false
	pass

func enter() -> void:
	player.climb_stamina -= player.hold.stamina_instant_drain
	climbing = true
	
	#keep velocity

	keep_velocity = player.velocity
	bool_velocity = true
	keep_velocity_timer.start()


	# player.global_position = player.hold.global_position
	tween = get_tree().create_tween()
	var new_position_y = player.hold.global_position.y + 6
	var new_position = Vector2(player.global_position.x, new_position_y)
	tween.tween_property(player, "global_position", new_position, 0.3).set_trans(Tween.TRANS_CUBIC)

	player.has_gravity = false
	player.velocity = Vector2(0, 0)
	player.can_jump = true
	player.can_move = true
	player.actual_max_speed = player.max_speed / 5
	player.hold.trigger()
	player.animated_sprite.play("climb")


func exit() -> void:
	player.has_gravity = true
	player.can_jump = false
	player.actual_max_speed = player.max_speed
	player.velocity.x = player.input_vector.x * player.actual_max_speed * 1.0
	if bool_velocity and abs(player.velocity.x) < abs(keep_velocity.x):
		player.velocity.x = keep_velocity.x 
	player.can_move = true

	keep_velocity_timer.stop()

func process(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		if tween.is_running():
			tween.stop()

	if player.is_on_floor():
		emit_signal("state_finished", self, "ground")
		return

	if player.climb_stamina <= 0 or \
		player.request_climb == false or \
		player.can_climb == false:
		emit_signal("state_finished", self, "air")
		return

	if player.hold != null:
		player.climb_stamina -= player.hold.stamina_drain * delta
		if player.climb_stamina <= 0:
			player.climb_stamina = 0
			emit_signal("state_finished", self, "air")
			return
	else:
		push_error("hold is null but player is climbing...")
	# var new_input_vector = Vector2()
	# new_input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	# player.velocity.y = new_input_vector.y * player.actual_max_speed

func _on_climbable_ended() -> void:
	if !climbing:
		return
	emit_signal("state_finished", self, "air")
	climbing = false
	pass # Replace with function body.


func _on_climbable_detected() -> void:
	pass # Replace with function body.
