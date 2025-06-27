extends StaticBody3D

## Временно
var score := 0


func _ready() -> void:
	var timer = ComponentLoaderUtil.get_component(self, "timer") as TimerComponent
	timer.stop()


func _on_interact() -> void:
	var timer = ComponentLoaderUtil.get_component(self, "timer") as TimerComponent
	timer.start()


func _on_stop_interacting() -> void:
	var timer = ComponentLoaderUtil.get_component(self, "timer") as TimerComponent
	timer.stop()


func _on_timeout() -> void:
	var timer = ComponentLoaderUtil.get_component(self, "timer") as TimerComponent
	timer.start()
	score += 1
	%Score.text = str(score) + "/20"
