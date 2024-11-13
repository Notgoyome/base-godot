extends Node2D

@export var jump_force = 300
@export var delta_y = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_detector_player_detected(player:Player):
	var push_vector : Vector2 = Vector2(0, -jump_force)
	var rotated_vector = push_vector.rotated(rotation)
	if rotation != 0 and rotation != 180:
		rotated_vector.x += delta_y
	player.velocity = rotated_vector
	pass # Replace with function body.

func trigger():
	if get_parent().has_method("trigger"):
		get_parent().trigger()