
extends Node2D

@export var tilemap : TileMapLayer
@export var tile_data : String

signal on_tile_data_detected
signal on_tile_data_end

var data_save = null

func _ready():
	pass

func _process(delta: float) -> void:
	var local_to_map = tilemap.local_to_map(global_position)
	var tile : TileData = tilemap.get_cell_tile_data(local_to_map)

	if tile == null:
		handle_tile_data_end_detection()
		return

	var data = tile.get_custom_data(tile_data)

	if data == null or data == false:
		handle_tile_data_end_detection()
		return

	if data_save == null:
		print("emitting signal")
		emit_signal("on_tile_data_detected")
		data_save = data
	
func handle_tile_data_end_detection():
	if data_save != null:
		emit_signal("on_tile_data_end")
		data_save = null
	pass
