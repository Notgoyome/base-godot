extends AnimatableBody2D
class_name TriggerMove
@export var speed = 200
var enabled = false
var flip = true
@onready var marker2d : Marker2D = $Marker2D
@onready var init_marker_pos = marker2d.global_position
@onready var init_pos = global_position


var delay_before_disable = 1
var timer_disable : Timer
# Called when the node enters the scene tree for the first time.
func _ready():
	print(init_pos)
	global_position = init_pos
	timer_disable = Timer.new()
	timer_disable.wait_time = delay_before_disable
	timer_disable.timeout.connect(disable)
	add_child(timer_disable)

	init_marker_pos = marker2d.global_position
	enabled = false
	flip = true
	pass # Replace with function body.

func trigger_fall():
	enabled = true

func trigger():
	enabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame                      .
func _process(delta):
	pass

func disable():
	enabled = false
	flip = !flip
	
func _physics_process(delta):
	#global_position.x += 15 * delta
	if enabled:
		if flip:
			var res = go_to(init_marker_pos, delta)

			if res:
				print("te")
				enabled = false
				flip = false
				
		if !flip:
			print("flop")
			var res = go_to(init_pos,delta)
			if res:
				enabled = false
				flip = true
				
func go_to(goal,delta):
	var old_distance = global_position.distance_to(goal)
	var normalize : Vector2 = Vector2(goal - global_position).normalized()
	
	#print(speed,normalize,delta," ", old_distance)
	global_position += speed * normalize * delta
	if (global_position.distance_to(goal) > old_distance or global_position == goal):
		#print(global_position.distance_to(goal), " ", old_distance)
		global_position = goal
		return true
		pass
	return false

func _on_area_2d_body_entered(body):
	pass # Replace with function body.
