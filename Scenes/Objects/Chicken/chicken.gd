extends RigidBody3D


const ITEM = preload("res://Assets/chicken/Chicken.glb")

var carry_obj = "Chicken2"
var took : bool = false

func _on_interactable_component_interacted() -> void:
	if !took:
		assert(has_meta("carry"))
		GlobalSignals.interuction_type_request.emit($CarryComponent._question_callback)
	
