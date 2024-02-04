class_name MainPlayer extends CharacterBody3D
# INCLUDES
static var Status = load("res://player/Scripts/Status.gd")
@onready var gravityValue = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var gravityVector = ProjectSettings.get_setting("physics/3d/default_gravity_vector")
# CONSTANTS
const PROCESSING_CICLES = 60
@onready var GRAVITY = (gravityValue/PROCESSING_CICLES) * gravityVector
const JOY_DEADZONE : float = 0.08
const BASE_MOVEMENT_SPEED = 10
const BASE_RUNNING_MULTIPLIER = 1.5
const PREPARE_RUN_TIME = 0.75
const DEFAULT_DODGE_DURATION = 10
const JUMPING_HEIGTH = 3.5
const JUMP_STAMINA_WASTE = 10
const ROLL_STAMINA_WASTE = 20
const RUNN_STAMINA_WASTE = 2.5
const DEFAULT_REGEN_WAITING = 2
enum MOVEMENT_STATUS {
	IDLE,
	WALKING,
	ROLLING,
	RUNNING,
	JUMPING
}
# STATIC FUNCTIONS
static func can_regen_stamina(m_status) -> bool:
	if m_status == MOVEMENT_STATUS.IDLE or m_status == MOVEMENT_STATUS.WALKING: 
		return true
	return false
static func get_JOY_AXIS_LEFT_X_Strength():
	var strength = Input.get_axis("move_forward","move_back")
	var usable = 1 if abs(strength) >= JOY_DEADZONE else 0
	return strength * usable
static func get_JOY_AXIS_LEFT_Y_Strength():
	var strength = Input.get_axis("move_left","move_right")
	var usable = 1 if abs(strength) >= JOY_DEADZONE else 0
	return strength * usable
static func jump_pressed() -> bool: return Input.is_action_pressed("jump")
static func joypad_get_movement_vector(camera_node):
	var movement_vector = Vector3.ZERO
	movement_vector.x = get_JOY_AXIS_LEFT_Y_Strength()
	movement_vector.z = get_JOY_AXIS_LEFT_X_Strength()
	movement_vector = movement_vector.rotated(Vector3.UP,camera_node.rotation.y).normalized()
	movement_vector *= BASE_MOVEMENT_SPEED
	return movement_vector
## INSTANCE VARIABLES
var status: Status
var _velocity : Vector3
var _snap_vector = Vector3.ZERO
var _movement_status = MOVEMENT_STATUS.IDLE
var _dodge_progress = 0
var _dodge_timer = 0
var _dodge_bonus_frames = 0
var _stamina_regen_timer = 0
var _essence_regen_timer = 0
var _roll_pressed = false
var _roll_released = false
@onready var _run_timer = $RunTimer
@onready var _cam_anchor = $Camera/cam_anchor
func _move(velocity_vector):
	velocity = velocity_vector
	move_and_slide()
func _has_landed() -> bool: return is_on_floor() and Vector3.ZERO != _snap_vector
func _init():
	status = Status.new(1,1,1,1)
	_velocity = Vector3.ZERO
func _ready():
	_init()
func _process(delta):
	update_stamina(delta)
	update_essence(delta)
	#update_rolling(delta)
func update_stamina(delta):
	if not status.stamina.is_already_max() and can_regen_stamina(_movement_status) and _stamina_regen_timer >= DEFAULT_REGEN_WAITING:
		status.stamina.regen_stamina(delta)
	else: _stamina_regen_timer += delta
func update_essence(delta):
	if not status.essence.is_already_max() and _essence_regen_timer >= DEFAULT_REGEN_WAITING:
		status.essence.regen_essence(delta)
	else: _essence_regen_timer += delta
func update_rolling(delta):
	if _movement_status == MOVEMENT_STATUS.ROLLING and _dodge_timer >= (DEFAULT_DODGE_DURATION + _dodge_bonus_frames):
		_movement_status = MOVEMENT_STATUS.IDLE
	elif _movement_status == MOVEMENT_STATUS.ROLLING and _dodge_timer < (DEFAULT_DODGE_DURATION + _dodge_bonus_frames):
		_dodge_timer += 1
# PHYSICS
func _physics_process(delta):
	process_movement(delta)
	process_gravity(delta)
	process_jump(delta)
	_move(_velocity)
func process_gravity(delta):
	if is_on_floor(): _velocity.y = 0
	else: _velocity += GRAVITY
func process_movement(delta):
	if is_on_floor():
		_velocity = joypad_get_movement_vector(_cam_anchor)
		if _velocity == Vector3.ZERO:
			_movement_status = MOVEMENT_STATUS.IDLE
		else:
			if _movement_status == MOVEMENT_STATUS.RUNNING:
				if status.stamina.depleated():
					_movement_status = MOVEMENT_STATUS.WALKING
				else:
					status.stamina.spend_stamina(RUNN_STAMINA_WASTE / 60)
					_stamina_regen_timer = 0
					_velocity *= BASE_RUNNING_MULTIPLIER
			else:
				_movement_status = MOVEMENT_STATUS.WALKING
	elif not is_on_floor():
		var new_vector = _velocity * (1 - delta)
		_velocity = Vector3(new_vector.x, _velocity.y, new_vector.z)
func process_jump(delta):
	var jump = is_on_floor() and jump_pressed()
	if jump and not status.stamina.depleated():
		status.stamina.spend_stamina(JUMP_STAMINA_WASTE)
		_velocity.y = JUMPING_HEIGTH
		_movement_status = MOVEMENT_STATUS.JUMPING
		_stamina_regen_timer = 0
# INPUT EVENTS
func _input(event):
	_roll_pressed = event.is_action_pressed("roll_run")
	if _roll_pressed:
		_run_timer.start()
	print(_roll_pressed)
	get_tree().create_timer(0.25).timeout
	_roll_released = event.is_action_released("roll_run")
	print(_roll_released)
	#if _roll_pressed:
		#_run_timer.start()
		#_roll_released = false

func _on_run_timer_timeout():
	if _roll_released and not status.stamina.depleated():
		_movement_status = MOVEMENT_STATUS.ROLLING
		status.stamina.spend_stamina(ROLL_STAMINA_WASTE)
		_stamina_regen_timer = 0
	elif not _roll_released and not status.stamina.depleated():
		_movement_status = MOVEMENT_STATUS.RUNNING
