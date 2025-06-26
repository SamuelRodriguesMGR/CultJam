extends RigidBody3D

const CANDLE = preload("res://Scenes/Candle/candle.tscn")

func _on_interactable_component_interacted() -> void:
	assert(has_meta("carry"))
	GlobalSignals.want_carry.emit(CANDLE)
