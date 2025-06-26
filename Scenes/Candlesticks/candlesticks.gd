extends StaticBody3D


@onready var player : CharacterBody3D = get_tree().current_scene.get_node("Character")

var carry_obj : StaticBody3D = null

func _on_interactable_component_interacted() -> void:
	if !player.hand.get_child_count() or carry_obj:
		return
	var candle = player.hand.get_child(0)
	player.hand.remove_child(candle)
	player.carry_obj = null
	
	candle.get_node("CollisionShape3D").disabled = false
	candle.position = $Marker3D.position
	carry_obj = candle
	add_child(candle)
	
	
