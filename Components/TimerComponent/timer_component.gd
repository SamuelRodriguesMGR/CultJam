class_name TimerComponent extends BaseComponent


signal timeout

@export var duration := 1.0

var timer := Timer.new()


func _ready() -> void:
	add_child(timer)
	timer.timeout.connect(_on_timeout)
	timer.start(duration)


func _on_timeout() -> void:
	timeout.emit()
	timer.start(duration)


func start() -> void:
	timer.start(duration)


func stop() -> void:
	timer.stop()


func pause() -> void:
	timer.paused = true


func unpause() -> void:
	timer.paused = false
