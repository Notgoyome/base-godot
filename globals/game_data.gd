extends Node

var player : Player = null
var player_respawn_point : Vector2 = Vector2(0, 0)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]
		player_respawn_point = player.global_position
	else:
		print("No player found in the scene")
	pass # Replace with function body.

func set_player_respawn_point(point: Vector2) -> void:
	player_respawn_point = point

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
