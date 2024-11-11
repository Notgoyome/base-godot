extends Node2D


func _on_player_detector_player_detected(body:Node2D) -> void:
    GameData.set_player_respawn_point(body.global_position)
    pass # Replace with function body.
