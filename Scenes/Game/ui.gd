extends CanvasLayer


func change_menu():
	if $Menu.visible:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	$Menu.visible = !$Menu.visible
	$BackMenu.visible = !$BackMenu.visible

func _ready() -> void:
	change_menu()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		change_menu()
	
func _on_button_resume_pressed() -> void:
	change_menu()
	
func _on_button_exit_pressed() -> void:
	get_tree().quit()
