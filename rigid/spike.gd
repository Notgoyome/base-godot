@tool
extends Node2D

@onready var nine_patch = $NinePatchRect
@onready var collision_shape : CollisionShape2D = $PlayerDetector/CollisionShape2D

var pixel_size = 8
@export var size: int = 1:
	set(value):
		size = value
		pixel_size = value * 8
		if not is_node_ready():
			await ready
		$NinePatchRect.size = Vector2(pixel_size, 8)
		var collision_rectangle : RectangleShape2D = collision_shape.shape
		collision_rectangle.size = Vector2(pixel_size, collision_rectangle.size.y)
		collision_shape.position = Vector2(pixel_size / 2, collision_shape.position.y)



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_detector_player_detected(body: Node2D) -> void:
	print("Player detected")
	Action.reload_current_scene()
	pass # Replace with function body.
