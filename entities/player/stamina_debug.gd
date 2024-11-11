extends Label

@onready var player : Player = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var stamina : int = player.climb_stamina
	text = "Stamina: " + str(stamina) + "\n"
	pass