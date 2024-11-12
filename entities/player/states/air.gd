extends State

@export var player: Player
# @export var dash: State
var coyote_time: float = 0.1
var coyote_timer: Timer = Timer.new()
var old_speed = 0
func _ready():
	coyote_timer.wait_time = coyote_time
	coyote_timer.one_shot = true
	coyote_timer.timeout.connect(_end_coyote)
	add_child(coyote_timer)

func enter() -> void:
	# player.has_friction = false
	# player.has_acceleration = false
	player.friction = 100
	# player.acceleration = 750
	old_speed = player.max_speed
	player.max_speed = player.max_speed
	if player.can_jump:
		coyote_timer.start()
		pass
	update_animation()

func process(delta: float) -> void:
	if player.can_climb and player.request_climb and int(player.climb_stamina) > 0:
		print("go", player.climb_stamina)
		emit_signal("state_finished", self, "climbing")
		return
	if player.is_on_floor():
		emit_signal("state_finished", self, "ground")
		return
	# if player.is_on_wall_only() and Input.is_action_just_pressed("jump"):
	# 	emit_signal("state_finished", self, "wall")
	# 	pass
	# if Input.is_action_just_pressed("dash") and dash.can_dash:
	# 	emit_signal("state_finished", self, "dash")
	update_animation()

func physic_process(delta: float) -> void:
	pass

func update_animation() -> void:
	if not player.is_falling:
		player.animated_sprite.play("jump")
	else:
		player.animated_sprite.play("fall")

func exit() -> void:
	coyote_timer.stop()
	player.max_speed = old_speed
	pass

func _end_coyote() -> void:
	player.can_jump = false
	pass
