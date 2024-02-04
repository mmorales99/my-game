extends Control

@export var Current_Player : MainPlayer

@onready var healthBar = $Status/Health
@onready var essenceBar = $Status/Ethereal_essence
@onready var staminaBar = $Status/Stamina
# Called when the node enters the scene tree for the first time.
func _ready():
	healthBar.init_health(Current_Player.status.health)
	essenceBar.init_essence(Current_Player.status.essence)
	staminaBar.init_stamina(Current_Player.status.stamina)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	staminaBar._process_stamina(Current_Player.status.stamina)
