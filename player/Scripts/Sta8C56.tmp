class_name Stamina

const DEFAULT_STAMINA_REGEN_FACTOR : float = 1
const DEFAULT_STAMINA_REGEN_QUANTUM : float  = 1
const STAMINA_REGEN_TIME = 1
const POINT_MULTIPLIER = 10
static func GetPointMultiplier():
	return POINT_MULTIPLIER

var stamina : int = 0

func regen_stamina(regen_add: float, regen_mult: float):
	stamina += ceili(\
			(DEFAULT_STAMINA_REGEN_QUANTUM + regen_add) \
			* (DEFAULT_STAMINA_REGEN_FACTOR + regen_mult)
			)
	pass
	
func spend_stamina(much: int):
	stamina -= much	
	pass

func _init(startAmount: int = 0):
	if(startAmount == 0):
		stamina = 1*POINT_MULTIPLIER
	else:
		stamina = startAmount
