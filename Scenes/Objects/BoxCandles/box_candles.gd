extends RigidBody3D


const CANDLE = preload("uid://caq83vst1bq6g")

func _on_interactable_component_interacted() -> void:
	assert(has_meta("carry"))
	GlobalSignals.interuction_type_request.emit(_question_callback)


func _question_callback(type: InteractionRequestEnum.types) -> void:
	match type:
		InteractionRequestEnum.types.WANT_CARRY:
			GlobalSignals.want_carry.emit(CANDLE)
		InteractionRequestEnum.types.WANT_OBJECT:
			GlobalSignals.want_object.emit("candle", func(): pass)
