extends RigidBody3D


const ITEM = preload("res://Assets/chicken/Chicken.glb")


func _on_interactable_component_interacted() -> void:
	assert(has_meta("carry"))
	GlobalSignals.interuction_type_request.emit($CarryComponent._question_callback)
	queue_free()
	
