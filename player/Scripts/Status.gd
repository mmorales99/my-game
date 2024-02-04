class_name Status extends Node3D

var EterealEssence = load("res://player/Scripts/Etereal_Essence.gd")
var Health = load("res://player/Scripts/Health.gd")
var Stamina = load("res://player/Scripts/Stamina.gd")
var Defense = load("res://player/Scripts/Defense.gd")

var health = Health.new()
var stamina = Stamina.new()
var essence = EterealEssence.new()
var defense = Defense.new()

func _init(
	healthPoints: int, 
	staminaPoints: int,
	essencePoints: int,
	defensePoints: int
	):
	health = Health.new(healthPoints * Health.GetPointMultiplier())
	stamina = Stamina.new(staminaPoints * Stamina.GetPointMultiplier())
	essence = EterealEssence.new(essencePoints * EterealEssence.GetPointMultiplier())
	defense = Defense.new(
			defensePoints * Defense.GetPointMultiplier(),
			defensePoints * Defense.GetPointMultiplier()
		)	
