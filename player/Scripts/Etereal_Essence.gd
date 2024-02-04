class_name EterealEssence

const DEFAULT_ESSENCE_REGEN_FACTOR : float = 1
const DEFAULT_ESSENCE_REGEN_QUANTUM : float  = 1
const ESSENCE_REGEN_TIME = 1
const POINT_MULTIPLIER = 50
static func GetPointMultiplier():
	return POINT_MULTIPLIER

var etereal_essence : int = 0
var max_essence : int = 0

func get_max_essence():
	return max_essence
	
func get_total_invested_points():
	return max_essence / POINT_MULTIPLIER

func set_amount(_essence):
	etereal_essence = min(max_essence,_essence)

func set_max_essence(_new_max):
	max_essence = _new_max
	return max_essence
	
func is_already_max():
	return etereal_essence >= max_essence

func get_actual_amount():
	return etereal_essence

func depleated():
	return etereal_essence <= 0

func regen_essence(regen_add: float = 0, regen_mult: float = 0):
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
	max_essence = startAmount
