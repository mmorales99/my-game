class_name Defense

const BASE_DEFENSE : int = 0
const FISICAL_ABSORBANCE : float = 0.5
const ETEREAL_ABSORBANCE : float = 0.3
const POINT_MULTIPLIER = 10
static func GetPointMultiplier():
	return POINT_MULTIPLIER

var fisical_defense: int = BASE_DEFENSE
var etereal_defense: int = BASE_DEFENSE
var fisical_reduction: float = FISICAL_ABSORBANCE
var etereal_reduction: float = ETEREAL_ABSORBANCE

func _init(startingFisicalDefense: int = 0, startingEterealDefense: int = 0):
	if(startingFisicalDefense == 0):
		fisical_defense = 1*POINT_MULTIPLIER
	else:
		fisical_defense = startingFisicalDefense
	if(startingEterealDefense == 0):
		etereal_defense = 1*POINT_MULTIPLIER
	else:
		etereal_defense = startingEterealDefense

func GetFisicalDamageTaken(damage: int):
	return (damage - (fisical_defense*fisical_reduction))

func GetEterealDamageTaken(damage: int):
	return (damage - (etereal_defense*etereal_reduction))
