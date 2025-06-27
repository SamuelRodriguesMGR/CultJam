extends StaticBody3D


const ITEM = preload("uid://caq83vst1bq6g")

@onready var carry_component: CarryComponent = $CarryComponent
var carry_obj = "candle"

func _on_interactable_component_interacted() -> void:
	assert(has_meta("carry"))
	GlobalSignals.interuction_type_request.emit(carry_component._question_callback)
	
