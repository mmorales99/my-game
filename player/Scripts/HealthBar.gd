extends ProgressBar

static var Health = load("res://player/Scripts/Health.gd")

@onready var timer = $DamageTimer
@onready var damageBar = $DamageBar
@onready var health : Health \
	: set = _process_health
# var prev_health_amount = 0

func _process_health(new_health):
	if health == null:
		health = new_health
	var prev_health_amount = health.get_actual_amount()
	health.set_amount(new_health.get_actual_amount())
	value = health.get_actual_amount()
	if health.depleated():
		queue_free()
	if health.get_actual_amount() < prev_health_amount:
		timer.start()
	else:
		damageBar.value = health.get_actual_amount()

func init_health(_health):
	health = _health
	var val = health.get_actual_amount()
	max_value = val
	value = val
	damageBar.max_value = val
	damageBar.value = val
	var newSize = Vector2(health.get_total_invested_points() + 99, 10)
	set_size(newSize)
	damageBar.set_size(newSize)

func _on_health_damage_timer_timeout():
	damageBar.value = health
	pass # Replace with function body.
