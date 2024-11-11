extends Node2D
class_name BumpComponent

@export var bump_force = 500
@export var reaction_force = 1.2

func _on_area_2d_body_entered(body:Node2D) -> void:
    if body is Player:

        var state_machine : StateMachine = body.get_node("StateMachine")
        if state_machine.current_state.name.to_lower() == "dash":
            body.velocity.y = -bump_force * reaction_force
            print(body.velocity.y)
        else:
            body.velocity.y = -bump_force
        state_machine.on_state_transition(state_machine.current_state, "ground")

    pass # Replace with function body.
