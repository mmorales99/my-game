class_name CameraController
extends Camera3D

const ENABLE_MOUSE_CAMERA = false
const JOY_DEADZONE : float = 0.18
const JOY_HORIZONTAL_SENSITIVITY : int = 3
const JOY_VERTICAL_SENSITIVITY : int = 3
const MAX_LATITUD = deg_to_rad(60)
const MIN_LATITUD = -deg_to_rad(60)

var camera_velocity: Vector2 = Vector2()
@onready var camera_anchor = get_parent_node_3d().get_parent_node_3d()

func _ready():
	if ENABLE_MOUSE_CAMERA: Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
func _input(event):
	if Input.get_connected_joypads().is_empty() or not event is InputEventJoypadMotion:
		mouse_controls(event)
	else: joypad_controls(event)
	
func _process(delta):
	camera_anchor.rotate_y(deg_to_rad(camera_velocity.y))
	var x = deg_to_rad(camera_velocity.x) + camera_anchor.rotation.x
	x = clamp(x, MIN_LATITUD, MAX_LATITUD)
	camera_anchor.rotation.x = x
	
const MOUSE_SENSITIVITY = 0.05
func mouse_controls(event):
	#if event is InputEventMouseMotion:
		#camera_velocity.x = event.relative.y * MOUSE_SENSITIVITY * 3.60
		#camera_velocity.y = event.relative.x * MOUSE_SENSITIVITY * 3.60
		#print(camera_velocity.y)
	pass
	
func joypad_controls(event):
	if event is InputEventJoypadMotion:
		var inputAxis = event.get_axis()
		var inputValue = event.get_axis_value()
		var usable = 1 if abs(inputValue) >= JOY_DEADZONE else 0
		match inputAxis:
			JOY_AXIS_RIGHT_Y: camera_velocity.x = (inputValue * JOY_HORIZONTAL_SENSITIVITY * usable) * -1
			JOY_AXIS_RIGHT_X: camera_velocity.y = (inputValue * JOY_VERTICAL_SENSITIVITY * usable) * -1
	else: mouse_controls(event)
