class_name CarryComponent extends BaseComponent


func _question_callback(type: InteractionRequestEnum.types) -> void:
	match type:
		InteractionRequestEnum.types.WANT_CARRY:
			GlobalSignals.want_carry.emit(owner.ITEM)
		InteractionRequestEnum.types.WANT_OBJECT:
			GlobalSignals.want_object.emit(owner.carry_obj, func(): pass)
