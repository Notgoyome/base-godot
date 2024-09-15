extends State

@export var player: Player

func enter() -> void:
	player.can_jump = false
	update_animation()

func process(delta: float) -> void:
	if player.is_on_floor():
		emit_signal("state_finished", self, "ground")
	update_animation()

func physic_process(delta: float) -> void:
	if Input.is_action_just_released("jump"):
		player.velocity.y *= 0.5

func update_animation() -> void:
	if not player.is_falling:
		player.animated_sprite.play("jump")
	else:
		player.animated_sprite.play("fall")

func exit() -> void:
	pass
