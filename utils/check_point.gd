extends Node2D

@onready var marker : Marker2D = $Marker2D

func _on_player_detector_player_detected(body:Player) -> void:
    GameData.set_player_respawn_point(marker.global_position)
    pass # Replace with function body.
