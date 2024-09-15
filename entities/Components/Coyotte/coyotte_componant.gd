extends Node
class_name CoyoteComponent

var coyote_timer : Timer = Timer.new()
var coyote_time : float = 0.1
var coyote_jump_requested : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	coyote_timer.wait_time = coyote_time
	coyote_timer.timeout.connect(_on_Timer_timeout)
	add_child(coyote_timer)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_coyote():
	coyote_jump_requested = true
	coyote_timer.start()
	pass

func _on_Timer_timeout() -> void:
	coyote_jump_requested = false
	pass