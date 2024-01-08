class_name Health

const DEFAULT_HEALTH_REGEN_FACTOR : float = 1
const DEFAULT_HEALTH_REGEN_QUANTUM : float  = 0
const HEALTH_REGEN_TIME = 1
const POINT_MULTIPLIER = 100
static func GetPointMultiplier():
	return POINT_MULTIPLIER

var health : int = 0

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

func _init(startAmount: int = 0):
	if(startAmount == 0):
		health = 1*POINT_MULTIPLIER
	else:
		health = startAmount
	
