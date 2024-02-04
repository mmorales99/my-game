class_name Health

const DEFAULT_HEALTH_REGEN_FACTOR : float = 1
const DEFAULT_HEALTH_REGEN_QUANTUM : float  = 0
const HEALTH_REGEN_TIME = 1
const POINT_MULTIPLIER = 100
const DEFAULT_DEATH_POINTS = 0
static func GetPointMultiplier():
	return POINT_MULTIPLIER

var health : int = 0
var max_health : int = 0

func get_max_health():
	return max_health
	
func get_total_invested_points():
	return max_health / POINT_MULTIPLIER

func set_amount(_health):
	health = min(max_health,_health)

func get_actual_amount():
	return health

func heal(much: int):
	health += much
	pass

func damage(much: int):
	health -= much
	pass

func heal_overtime(regen_quantum: int, regen_factor: float):
	health += floor(\
		(DEFAULT_HEALTH_REGEN_QUANTUM + regen_quantum)\
		*(DEFAULT_HEALTH_REGEN_FACTOR + regen_factor)
	)

func damage_overtime(damageTaken: int):
	health -= damageTaken

func depleated():
	return health <= DEFAULT_DEATH_POINTS #+ EXECUTION_THRESHOLD

func _init(startAmount: int = 0):
	if(startAmount == 0):
		health = 1*POINT_MULTIPLIER
	else:
		health = startAmount
	max_health = health
