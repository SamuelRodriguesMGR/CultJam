extends StaticBody3D


@onready var player : CharacterBody3D = get_tree().current_scene.get_node("Character")

func _on_interactable_component_interacted() -> void:
	if !player.hand.get_child_count():
		return
	var candle = player.hand.get_child(0)
	player.hand.remove_child(candle)
	add_child(candle)
