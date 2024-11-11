extends Node

var retry_scene : PackedScene = preload("res://ui/retry.tscn")
var retry_instance : Node = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	retry_instance = retry_scene.instantiate()
	add_child(retry_instance)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("reload"):
		# reload_current_scene()
		get_tree().reload_current_scene()
		# await get_tree().proce


	pass


func reload_current_scene() -> void:
	var retry_animation_player : AnimationPlayer = retry_instance.get_node("AnimationPlayer")
	var players = get_tree().get_nodes_in_group("player")
	if players.size() == 0:
		print("No player found in the scene")
		return
	var player = players[0]
	player.hide()

	player.global_position = GameData.player_respawn_point
	retry_animation_player.play("new_animation")

	await retry_animation_player.animation_finished

	var resetables = get_tree().get_nodes_in_group("resetable")
	for resetable in resetables:
		resetable._ready()

	retry_animation_player.play("end")
	player.show()
	#TODO: reinitalisez tous les objets du jeu