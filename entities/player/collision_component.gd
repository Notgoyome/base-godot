extends Area2D

@export var player : Node2D
var climb_enter_nb = 0
var hold : Hold
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if player == null:
		push_error("player is null")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body:Node2D) -> void:
	pass

func _on_area_entered(area:Area2D) -> void:
	if area is Hold:
		player.can_climb = true
		player.hold = area
	pass

func _on_area_exited(area:Area2D) -> void:
	if area is Hold:
		# climb_enter_nb -= 1
		# if climb_enter_nb <= 0:
		player.can_climb = false
	pass
