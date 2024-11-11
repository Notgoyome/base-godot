extends State

@export var player: Player
@export var dash : State = null
signal on_floor
func enter() -> void:
	player.has_acceleration = true
	player.has_friction = true
	player.friction = 800
	player.acceleration = 1200
	player.can_jump = true
	player.climb_stamina = 100
	on_floor.emit()
	pass

func process(delta: float) -> void:
	if not player.is_moving:
		player.animated_sprite.play("idle")
	else:
		player.animated_sprite.play("run")
	if not player.is_on_floor():
		emit_signal("state_finished", self, "air")
		return
	# if Input.is_action_just_pressed("dash") and dash.can_dash:
	# 	emit_signal("state_finished", self, "dash")
	pass

func physic_process(delta: float) -> void:
	pass

func exit() -> void:
	pass
