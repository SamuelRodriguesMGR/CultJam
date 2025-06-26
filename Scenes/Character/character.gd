class_name Character extends CharacterBody3D


const WALK_SPEED : float = 5.0
const SPRINT_SPEED : float = 8.0
const JUMP_VELOCITY : float = 4.8
const FRICTION : float = 0.1
const SENSITIVITY : float = 0.004

#bob variables
const BOB_FREQ : float= 2.4
const BOB_AMP : float = 0.08
var t_bob : float = 0.0

#fov variables
const BASE_FOV : float = 75.0
const FOV_CHANGE : float = 1.5

@onready var camera : Camera3D = $Body/Camera3D
@onready var body : Node3D = $Body
@onready var hand : Node3D = %Hand


var move_direction : Vector3
var speed : float

var carry_obj = null

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	GlobalSignals.want_carry.connect(want_carry_process)
	GlobalSignals.want_object.connect(want_object_process)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		key_process(event)

	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
	if event is InputEventMouseMotion:
		body.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(60))


func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta

	# Handle Jump.
	#if Input.is_action_just_pressed("ui_select") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Handle Sprint.
	if Input.is_action_pressed("shift"):
		speed = SPRINT_SPEED
	else:
		speed = WALK_SPEED

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (body.transform.basis * transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 7.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 3.0)

	# Head bob
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)

	# FOV
	var velocity_clamped = clamp(velocity.length(), 0.5, SPRINT_SPEED * 2)
	var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
	camera.fov = lerp(camera.fov, target_fov, delta * 8.0)

	move_and_slide()


func _headbob(time: float) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos


func key_process(event: InputEventKey) -> void:
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if event.keycode == KEY_E:
		var object := ray_cast_interact_process()
		
		if not object:
			return
		
		if object.has_meta("interactable"):
			(object.get_meta("interactable") as InteractableComponent).interact()


func ray_cast_interact_process() -> Object:
	if not %RayCastInteract.is_colliding():
		return null
	return %RayCastInteract.get_collider()


func want_carry_process(object: PackedScene) -> void:
	if carry_obj:
		return
	
	var inst_object : Node3D = object.instantiate()
	hand.add_child(inst_object)
	
	carry_obj = inst_object


func want_object_process(object_name: String, callback: Callable) -> void:
	if not carry_obj or not carry_obj.name == object_name:
		return
	
	clear_object_hand()
	
	callback.call()

func clear_object_hand():
	# Очищает предмет в руке
	
	carry_obj = null
	
	for child in hand.get_children():
		child.queue_free()
