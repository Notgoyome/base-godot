extends Node
class_name JumpBufferComponent

@export var jump_buffer_time: float = 0.1
var jump_requested: bool = false
var timer : Timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = jump_buffer_time
	timer.timeout.connect(_on_Timer_timeout)
	add_child(timer)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("jump")):
		jump_requested = true
		timer.start()
	pass

func _input(event: InputEvent) -> void:
	
	pass

func _on_Timer_timeout() -> void:
	jump_requested = false
	pass