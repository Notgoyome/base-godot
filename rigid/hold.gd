@tool
extends Area2D

class_name Hold

@export var stamina_drain = 1
@export var stamina_instant_drain = 10
@export var breakable = false
var breakable_delay = 0.5
var breakable_timer : Timer
var broken = false

var respawn_time = 3
var respawn_timer : Timer

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape : CollisionShape2D = $CollisionShape2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    breakable_timer = Timer.new()
    breakable_timer.wait_time = breakable_delay
    breakable_timer.one_shot = true
    add_child(breakable_timer)
    breakable_timer.timeout.connect(_on_breakable_timer_timeout)

    respawn_timer = Timer.new()
    respawn_timer.wait_time = respawn_time
    respawn_timer.one_shot = true
    add_child(respawn_timer)
    respawn_timer.timeout.connect(_on_respawn_timer_timeout)

    if breakable:
        sprite.play("breakable")

    _on_respawn_timer_timeout()
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

func trigger() -> void:
    if breakable:
        breakable_timer.start()
        shake_position(breakable_delay, 1,20, sprite)
        pass
    if get_parent().has_method("trigger"):
        get_parent().trigger()
    pass

func _on_breakable_timer_timeout() -> void:
    broken = true
    sprite.hide()
    collision_shape.disabled = true
    respawn_timer.start()

func _on_respawn_timer_timeout() -> void:
    broken = false
    sprite.show()
    collision_shape.disabled = false

func shake_position(duration: float, strength: float, frequence: int, node: Node) -> Tween:
    var tween = create_tween()
    var start_position = node.position

    var x = 0
    var y = 0

    for i in range(frequence):
        if i %2 == 0:
            x = 1
        if i %2 == 1:
            x = -1

        
        tween.tween_property(node, "position", 
            start_position + Vector2(x, y), 
            duration/frequence)
        
        tween.tween_property(node, "position", 
            start_position, 
            duration/frequence)
    
    return tween

