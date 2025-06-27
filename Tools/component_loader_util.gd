class_name ComponentLoaderUtil extends Node


static func get_component(component_owner: Node, component_name: String) -> BaseComponent:
	if component_owner.has_meta(component_name):
		return component_owner.get_meta(component_name) as BaseComponent
	
	push_error("Component " + component_name + " not found on class " + component_owner.get_class())
	return null
