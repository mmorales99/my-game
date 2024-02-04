class_name Stamina

const DEFAULT_STAMINA_REGEN_FACTOR : float = 1
const DEFAULT_STAMINA_REGEN_QUANTUM : float = 10
const STAMINA_REGEN_TIME = 1
const POINT_MULTIPLIER = 100
static func GetPointMultiplier():
	return POINT_MULTIPLIER

var stamina : float = 0
var max_stamina : float = 0

func get_max_stamina():
	return max_stamina

func set_max_stamina(_new_max):
	max_stamina = _new_max
	return max_stamina
	
func is_already_max():
	var ret = stamina >= max_stamina
	return ret
	
func get_total_invested_points():
	return max_stamina / POINT_MULTIPLIER
	
func set_amount(_stamina):
	stamina = min(max_stamina,_stamina)
	
func get_actual_amount():
	return stamina

func depleated():
	return stamina <= 0

func regen_stamina(delta : float, regen_add: float = 0, regen_mult: float = 0):
	set_amount(
		stamina + 
				(DEFAULT_STAMINA_REGEN_QUANTUM + regen_add) \
				* (DEFAULT_STAMINA_REGEN_FACTOR + regen_mult) \
				* delta
	)
	
func spend_stamina(much: float):
	stamina -= much	
	pass

func _init(startAmount: float = 0):
	if(startAmount == 0):
		stamina = 1*POINT_MULTIPLIER
	else:
		stamina = startAmount
	max_stamina = startAmount
