class_name BaseComponent extends Node


@export var component_name: String = "Component"


func _enter_tree() -> void:
	owner.set_meta(component_name, self)


func _exit_tree() -> void:
	owner.remove_meta(component_name)
