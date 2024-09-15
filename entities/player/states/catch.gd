extends State

@export var player: Player

func enter() -> void:
	player.can_jump = false
	player.can_move = false
	pass

func process(delta: float) -> void:
	if not player.is_moving:
		player.animated_sprite.play("idle")
	else:
		player.animated_sprite.play("run")
	if not player.is_on_floor():
		emit_signal("state_finished", self, "air")
	pass

func physic_process(delta: float) -> void:
	pass

func exit() -> void:
	pass
