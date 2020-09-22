extends Spatial

onready var franka = $Franka
onready var character = $Character
onready var message_label = $MessageLabel

func _input(event):
	if event.is_action("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			character.pan(event.relative)
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			character.interact(franka)

func _physics_process(delta):
	character.walk(delta)

func _process(delta):
	message_label.text = ""
	if character.is_looking_at(franka):
		message_label.text = "Click to interact with Franka"
