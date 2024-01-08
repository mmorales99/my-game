class_name MainPlayer extends CharacterBody3D

# CONSTANTS
@onready var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") * ProjectSettings.get_setting("physics/3d/default_gravity_vector")
const BASE_MOVEMENT_SPEED = 3
const JOY_DEADZONE : float = 0.18

var Status = load("res://player/Scripts/Status.gd")

var status: Status
var vertical_speed = Vector3.ZERO
var movement_velocity: Vector3 = Vector3()

func _init():
	status = Status.new(1,1,1,1)

func _ready():
	pass

var actualDelta
func _process(delta):
	actualDelta = delta
	var movementVector = (movement_velocity * delta * BASE_MOVEMENT_SPEED)
	move_and_collide(movementVector)
	pass

func _input(event):
	if Input.get_connected_joypads().is_empty() or not event is InputEventJoypadMotion:
		keyboard_controls(event)
	else: joypad_controls(event)

func joypad_controls(event):
	if event is InputEventJoypadMotion:
		var inputAxis = event.get_axis()
		var inputValue = event.get_axis_value()
		var usable = 1 if abs(inputValue) >= JOY_DEADZONE else 0
		match inputAxis:
			JOY_AXIS_LEFT_X: movement_velocity.x = inputValue * usable
			JOY_AXIS_LEFT_Y: movement_velocity.z = inputValue * usable
	else: keyboard_controls(event)
	
func keyboard_controls(event):
	movement_velocity.x = Input.get_axis("move_left","move_right")
	movement_velocity.z = Input.get_axis("move_forward","move_back")
