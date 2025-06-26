extends StaticBody3D


var damage := 5
var is_active := true


func _interact() -> void:
	var health_component = get_component("health") as HealthComponent
	
	if health_component.current_health <= 0:
		GlobalSignals.want_object.emit("candle", want_object_callback)
	else:
		var timer_component = get_component("timer") as TimerComponent
		timer_component.start()
		turn_fire(true)


func want_object_callback() -> void:
	var health_component = get_component("health") as HealthComponent
	health_component.restore_health()
	var timer_component = get_component("timer") as TimerComponent
	timer_component.start()
	turn_fire(true)


func _on_timer_component_timeout() -> void:
	if not is_active:
		return
	
	var health_component = get_component("health") as HealthComponent
	health_component.change_health(-damage)
	
	if randi_range(1, 5) == 1:
		turn_fire(false)
		var timer_component = get_component("timer") as TimerComponent
		timer_component.stop()


func _on_health_component_health_updated(new_health: int) -> void:
	if new_health > 80:
		%AnimationPlayer.play("state_0")
	elif new_health > 50:
		%AnimationPlayer.play("state_1")
	elif new_health > 20:
		%AnimationPlayer.play("state_2")
	else:
		%AnimationPlayer.play("state_3")


func get_component(component_name: String) -> BaseComponent:
	if not has_meta(component_name):
		print(component_name + " not found on class " + str(self.get_class()))
		return null
	
	return get_meta(component_name)


func turn_fire(state: bool) -> void:
	is_active = state
	%FireParticles.emitting = state


func _on_health_component_death() -> void:
	turn_fire(false)
