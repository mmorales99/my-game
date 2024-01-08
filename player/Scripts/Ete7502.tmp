class_name EterealEssence

const DEFAULT_ESSENCE_REGEN_FACTOR : float = 1
const DEFAULT_ESSENCE_REGEN_QUANTUM : float  = 1
const ESSENCE_REGEN_TIME = 1
const POINT_MULTIPLIER = 50
static func GetPointMultiplier():
	return POINT_MULTIPLIER

var etereal_essence : int = 0

func regen_essence(regen_add: float, regen_mult: float):
	etereal_essence += ceili(\
			(DEFAULT_ESSENCE_REGEN_QUANTUM + regen_add) \
			* (DEFAULT_ESSENCE_REGEN_FACTOR + regen_mult)
			)
	pass
	
func spend_essence(much: int):
	etereal_essence -= much	
	pass
	
func fill_essence(much: int):
	etereal_essence += much
	pass
	
func _init(startAmount: int = 0):
	if(startAmount == 0):
		etereal_essence = 1*POINT_MULTIPLIER
	else:	
		etereal_essence = startAmount
	
