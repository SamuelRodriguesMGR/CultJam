class_name Candle extends StaticBody3D


signal active_changed(state: bool)

var damage := 5
var is_active := true
var health_component : HealthComponent
var timer_component : TimerComponent


func _ready() -> void:
	health_component = ComponentLoaderUtil.get_component(self, "health")
	timer_component = ComponentLoaderUtil.get_component(self, "timer")


func _interact() -> void:
	if is_active:
		return
	
	if health_component.current_health <= 0:
		GlobalSignals.want_object.emit("candle", want_object_callback)
	else:
		timer_component.start()
		turn_fire(true)


func want_object_callback() -> void:
	health_component.restore_health()
	timer_component.start()
	turn_fire(true)


func _on_timer_component_timeout() -> void:
	if not is_active:
		return
	
	health_component.change_health(-damage)
	
	if randi_range(1, 5) == 1:
		turn_fire(false)
		timer_component.stop()


func _on_health_component_health_updated(new_health: int) -> void:
	if new_health > 80:
		%AnimationPlayer.play("state_0")
	elif new_health > 50:
		%AnimationPlayer.play("state_1")
	elif new_health > 20:
		%AnimationPlayer.play("state_2")
	elif new_health > 0:
		%AnimationPlayer.play("state_3")
	else:
		%AnimationPlayer.play("state_4")


func turn_fire(state: bool) -> void:
	is_active = state
	%FireParticles.emitting = state
	active_changed.emit(state)


func _on_health_component_death() -> void:
	turn_fire(false)
	timer_component.stop()
