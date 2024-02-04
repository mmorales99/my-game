extends ProgressBar

static var EterealEssence = load("res://player/Scripts/Etereal_Essence.gd")

@onready var timer = $DamageTimer
@onready var damageBar = $DamageBar
@onready var essence : EterealEssence \
	: set = _process_essence
# var prev_health_amount = 0

func _process_essence(new_essence):
	if essence == null:
		essence = new_essence
	var new_essence_amount = new_essence.get_actual_amount()
	var prev_essence_amount = essence.get_actual_amount()
	essence.set_amount(new_essence_amount)
	var act_essence_amount = essence.get_actual_amount()
	value = act_essence_amount
	if act_essence_amount < prev_essence_amount:
		timer.start()
	elif act_essence_amount > prev_essence_amount:
		damageBar.value = act_essence_amount

func init_essence(_essence):
	essence = _essence
	var val = essence.get_actual_amount()
	max_value = val
	value = val
	damageBar.max_value = val
	damageBar.value = val
	var newSize = Vector2(essence.get_total_invested_points() + 99, 10)
	set_size(newSize)
	damageBar.set_size(newSize)

func _on_essence_damage_timer_timeout():
	damageBar.value = essence
	pass # Replace with function body.
