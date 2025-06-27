## Класс для продолжительных взаимодействий
class_name ContinuousInteractiveComponent extends InteractableComponent

signal stoped_interacting

func stop_interacting() -> void:
	stoped_interacting.emit()
