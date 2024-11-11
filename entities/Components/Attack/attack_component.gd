extends Node2D

@export var player: Player = null
@export var x_gap = 16
@export var y_gap = 32

@export var time_before_hit = 0
@export var time_hit = 0.05

@onready var area : Area2D = $Area2D
@onready var collision_shape : CollisionShape2D = area.get_node("CollisionShape2D")

var list_bodies = []

var attack_start_timer: Timer = null
var attack_hit_timer: Timer = null

func _ready() -> void:
    # Initialisation des timers
    attack_start_timer = Timer.new()
    attack_start_timer.wait_time = time_before_hit
    attack_start_timer.one_shot = true
    attack_start_timer.connect("timeout", Callable(self, "start_hit"))

    attack_hit_timer = Timer.new()
    attack_hit_timer.wait_time = time_hit
    attack_hit_timer.one_shot = true
    attack_hit_timer.connect("timeout", Callable(self, "end_hit"))

    add_child(attack_start_timer)
    add_child(attack_hit_timer)

func _process(delta: float) -> void:
    if Input.is_action_just_pressed("attack"):
        if time_before_hit == 0:
            start_hit()
        else:
            attack_start_timer.start()

func _on_area_2d_body_entered(body: Node2D) -> void:
    if body == player:
        return

    if body not in list_bodies:
        list_bodies.append(body)

func start_hit() -> void:
    list_bodies.clear()

    if player.last_input_vector.y != 0:
        area.position = Vector2(0, player.last_input_vector.y * y_gap)
    else:
        area.position = Vector2(player.last_input_vector.x * x_gap, 0)

    area.monitoring = true
    attack_hit_timer.start()

func end_hit() -> void:
    area.monitoring = false

    apply_hit()

func apply_hit() -> void:
    for body in list_bodies:
        #check if has node bumpComponent
        if body.has_node("BumpComponent"):
            var bump_component : BumpComponent = body.get_node("BumpComponent")
            #get distance between body and player
            var bump_vector : Vector2 = (player.global_position - body.global_position)
            if abs(bump_vector.x) >= abs(bump_vector.y):
                bump_vector.y = 0
            if abs(bump_vector.y) >= abs(bump_vector.x):
                bump_vector.x = 0
            bump_vector = bump_vector.normalized()
            bump_vector *= bump_component.bump_force

            if player:
                player.velocity += bump_vector

        print("Hit body: ", body.name)
