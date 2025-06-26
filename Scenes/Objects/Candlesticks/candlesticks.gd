extends StaticBody3D


const CANDLE = preload("res://Scenes/Objects/Candle/candle.tscn")

@onready var player : CharacterBody3D = get_tree().current_scene.get_node("Character")
var carry_obj : StaticBody3D = null

func _on_interactable_component_interacted() -> void:
	if !player.hand.get_child_count() or carry_obj:
		return
		
	player.clear_object_hand()
	
	var candle = CANDLE.instantiate()
	add_child(candle)
	
	candle.position = $Marker3D.position
	carry_obj = candle
	
	
