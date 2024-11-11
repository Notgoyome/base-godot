extends State

@export var player : Player = null

var can_dash = true
var dash_distance = 16 * 3
var dash_time = 0.05

var dash_velocity = dash_distance / dash_time
var dash_timer : Timer = Timer.new()

var dash_direction : Vector2 = Vector2.ZERO

func _ready() -> void:
	dash_timer.wait_time = dash_time
	dash_timer.one_shot = true
	dash_timer.timeout.connect(_on_dash_timer_timeout)
	add_child(dash_timer)
	pass # Replace with function body.


func enter() -> void:
	can_dash = false
	player.has_acceleration = false
	player.has_friction = false
	player.has_gravity = false
	player.can_move = false
	dash_direction = player.last_input_vector.normalized()
	player.velocity = dash_direction * dash_velocity
	dash_timer.start()
	pass

func process(delta: float) -> void:
	pass

func _on_dash_timer_timeout() -> void:
	reset_state()
	pass

func exit() -> void:
	player.has_acceleration = true
	player.has_friction = true
	player.has_gravity = true
	player.can_move = true
	dash_timer.stop()

func _recover_dash() -> void:
	can_dash = true
	pass

func reset_state() -> void:
	dash_timer.stop()
	player.velocity *= 0.3
	print(player.velocity)
	if player.is_on_floor():
		emit_signal("state_finished", self, "ground")
		return
	emit_signal("state_finished", self, "air")