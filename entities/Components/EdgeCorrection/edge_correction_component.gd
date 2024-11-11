extends Node2D

@export var player : Player = null
@export var edge_corrector_gap = 40000
@export var enabled = false
@onready var left_out : RayCast2D = $left_out
@onready var left_in : RayCast2D  = $left_in

@onready var right_in : RayCast2D  = $right_in
@onready var right_out : RayCast2D  = $right_out

func _ready() -> void:
    set_process(false)

func _process(delta: float) -> void:
    if !enabled:
        return
    if not left_in.is_colliding() and left_out.is_colliding():
        # player.velocity.x += edge_corrector_gap * delta
        player.global_position.x += edge_corrector_gap * delta
    if not right_in.is_colliding() and right_out.is_colliding():
        # player.velocity.x -= edge_corrector_gap * delta
        player.global_position.x -= edge_corrector_gap * delta

        pass
    pass



func _on_air_state_finished(state: State, new_state_name: String) -> void:
    print("false")
    set_process(false)
    pass # Replace with function body.


func _on_air_state_enter() -> void:
    print("true")
    set_process(true)
    pass # Replace with function body.
