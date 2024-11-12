extends Area2D

var camera = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#get the camera of group main_camera
	camera = get_tree().get_nodes_in_group("main_camera")
	if camera.size() > 0:
		camera = camera[0]
		print("camera found")
	else:
		print("camera not found")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area:Area2D) -> void:
	if area is CameraMapManager:
		print("camera map detected")
		if camera != null and camera is Camera2D:
			camera.global_position = area.global_position
		
	pass # Replace with function body.
