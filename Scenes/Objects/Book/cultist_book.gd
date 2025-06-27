extends StaticBody3D


@export var stability_heal_value: int = 5

var score := 0
var timer : TimerComponent
var is_interacting := false


func _ready() -> void:
	timer = ComponentLoaderUtil.get_component(self, "timer") as TimerComponent
	timer.stop()


func _on_interact() -> void:
	is_interacting = true
	timer.start()


func _on_stop_interacting() -> void:
	is_interacting = false
	timer.stop()


func _on_timeout() -> void:
	if is_interacting:
		timer.start()
	
	score += 1
	%Score.text = str(score) + "/20"
	
	GlobalSignals.change_stability.emit(stability_heal_value)
