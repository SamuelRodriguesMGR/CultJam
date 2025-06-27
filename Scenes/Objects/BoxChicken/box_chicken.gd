extends StaticBody3D


const ITEM = preload("res://Assets/chicken/Chicken.glb")

@onready var points_chicken  : Node = $PointsChicken
var carry_obj = "Chicken2"

func _ready() -> void:
	for point in points_chicken.get_children():
		var ch = ITEM.instantiate()
		add_child(ch)
		ch.position = point.position
		ch.rotation.y = randi_range(1, 360)


func _on_interactable_component_interacted() -> void:
	assert(has_meta("carry"))
	GlobalSignals.interuction_type_request.emit($CarryComponent._question_callback)
