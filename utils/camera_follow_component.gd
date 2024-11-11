extends Area2D

@export var camera: Camera2D 
var tween: Tween
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body:Node2D) -> void:
	if body is Player:
		tween = get_tree().create_tween()
		tween.tween_property(camera, "global_position", self.global_position, 0.5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	pass # Replace with function body.
