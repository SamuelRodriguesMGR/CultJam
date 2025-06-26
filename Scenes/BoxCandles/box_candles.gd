extends RigidBody3D


const CANDLE = preload("res://Scenes/Candle/candle.tscn")

func spawn_candle(pos : Vector3) -> void:
	var new_candle : StaticBody3D = CANDLE.instantiate()
	get_tree().current_scene.add_child(new_candle)
	new_candle.position = pos

func _on_interactable_component_interacted() -> void:
	spawn_candle(get_tree().current_scene.get_node("Character").marker_interact.global_position)
