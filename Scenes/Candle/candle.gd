extends StaticBody3D


@export var stages : Array[ArrayMesh]

var damage := 5
var is_active := true


func _interact() -> void:
	if not has_meta("health"):
		print("HealthComponent not found on class " + self.get_class())
		return
	
	var health_component = get_meta("health") as HealthComponent
	health_component.restore_health()


func _on_timer_component_timeout() -> void:
	if not has_meta("health"):
		print("HealthComponent not found on class " + self.get_class())
		return
	
	var health_component = get_meta("health") as HealthComponent
	health_component.change_health(-damage)


func _on_health_component_health_updated(new_health: int) -> void:
	if new_health > 80:
		%CandleMesh.mesh = stages[0]
	elif new_health > 50:
		%CandleMesh.mesh = stages[1]
	elif new_health > 20:
		%CandleMesh.mesh = stages[2]
	else:
		%CandleMesh.mesh = stages[3]
