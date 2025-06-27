class_name InteractableComponent extends BaseComponent


signal interacted


func _enter_tree() -> void:
	super()
	assert(owner is CollisionObject3D)


func interact() -> void:
	interacted.emit()
