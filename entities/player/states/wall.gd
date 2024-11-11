extends State

@export var player: Player

func enter() -> void:
	player.can_jump  = false
	player.has_gravity = false
	pass

func process(delta: float) -> void:
	if not player.is_on_floor() and player.is_moving:
		emit_signal("state_finished", self, "air")
	pass

func physic_process(delta: float) -> void:
	pass

func exit() -> void:
	player.has_gravity = true
	pass
