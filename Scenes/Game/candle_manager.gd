extends Node


var start_ammount: int = 0
var current_ammount: int


func _ready() -> void:
	for candle: Candle in get_children():
		start_ammount += 1
		candle.active_changed.connect(state_changed)
	current_ammount = start_ammount


func state_changed(is_active) -> void:
	if is_active:
		current_ammount += 1
		GlobalSignals.ammount_of_working_candles_changed.emit(float(current_ammount) / start_ammount)
	else:
		current_ammount -= 1
		GlobalSignals.ammount_of_working_candles_changed.emit(float(current_ammount) / start_ammount)
