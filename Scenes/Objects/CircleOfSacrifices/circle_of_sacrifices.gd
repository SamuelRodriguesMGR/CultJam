extends CSGBox3D

@export var base_damage: int = 0
@export var max_damage: int = 10


var current_damage: int
var timer: TimerComponent
var health: HealthComponent


func _ready() -> void:
	timer = ComponentLoaderUtil.get_component(self, "timer")
	health = ComponentLoaderUtil.get_component(self, "health")
	current_damage = base_damage
	GlobalSignals.ammount_of_working_candles_changed.connect(damage_change)
	GlobalSignals.change_stability.connect(health.change_health)


# Поражение
func _on_death() -> void:
	timer.stop()
	GlobalSignals.change_stability.disconnect(health.change_health)


func _on_health_updated(new_health: int) -> void:
	%Stability.text = str(new_health)


func _on_timeout() -> void:
	health.change_health(-current_damage)
	timer.start()


func damage_change(power: float) -> void:
	if power == 1.0:
		timer.pause()
	else:
		timer.unpause()
	
	current_damage = int(max_damage - (max_damage - base_damage) * power)
