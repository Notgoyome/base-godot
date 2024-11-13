extends State

@export var player: Player
var climbing = false
var tween : Tween
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func enter() -> void:
	player.climb_stamina -= player.hold.stamina_instant_drain
	climbing = true

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
	print(player.max_speed)
	player.velocity.x = player.input_vector.x * player.actual_max_speed * 1.0
	player.can_move = true

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
	print("climbable ended")
	emit_signal("state_finished", self, "air")
	climbing = false
	pass # Replace with function body.


func _on_climbable_detected() -> void:
	pass # Replace with function body.
