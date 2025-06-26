class_name HealthComponent extends BaseComponent


signal health_updated(new_health: int)
signal death

@export var max_health: int = 100

var current_health := max_health


func restore_health() -> void:
	current_health = max_health
	health_updated.emit(current_health)


func change_health(ammount: int) -> void:
	current_health += ammount
	
	if current_health <= 0:
		current_health = 0
		death_process()
	elif current_health > max_health:
		current_health = max_health
	
	health_updated.emit(current_health)


func death_process() -> void:
	death.emit()
