extends RigidBody3D


const CANDLE = preload("uid://caq83vst1bq6g")

func _on_interactable_component_interacted() -> void:
	assert(has_meta("carry"))
	GlobalSignals.want_carry.emit(CANDLE)
