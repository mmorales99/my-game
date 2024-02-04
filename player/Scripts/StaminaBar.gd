extends ProgressBar

static var Stamina = load("res://player/Scripts/Stamina.gd")

@onready var timer = $DamageTimer
@onready var damageBar = $DamageBar
@onready var stamina : Stamina \
	: set = _process_stamina

func _process_stamina(new_stamina):
	if stamina == null:
		stamina = new_stamina
	var new_stamina_amount = new_stamina.get_actual_amount()
	var prev_stamina_amount = stamina.get_actual_amount()
	stamina.set_amount(new_stamina_amount)
	var act_stamina_amount = stamina.get_actual_amount()
	value = act_stamina_amount
	if act_stamina_amount < prev_stamina_amount:
		timer.start()
	elif act_stamina_amount > prev_stamina_amount:
		damageBar.value = stamina.get_actual_amount()
			
func init_stamina(_stamina):
	stamina = _stamina
	var val = stamina.get_actual_amount()
	max_value = val + 1
	value = val + 1
	damageBar.max_value = val
	damageBar.value = val
	var newSize = Vector2(stamina.get_total_invested_points() + 99, 10)
	set_size(newSize)
	damageBar.set_size(newSize)

func _on_stamina_damage_timer_timeout():
	damageBar.value = stamina.get_actual_amount()
