class_name HotkeyRebindButton
extends Control

@export var label: Label
@export var button: Button
@export var action_name: String = "move_left"

func _ready():
	set_process_unhandled_key_input(false)
	button.toggled.connect(_on_button_toggled)

func set_action_name() -> void:
	label.text = "Unassigned"

	match action_name:
		"move_left":
			label.text = "Move Left"
		"move_right": 
			label.text = "Move Right"
		"jump":
			label.jump = "Jump"


func set_text_for_key() -> void:
	var action_events = InputMap.action_get_events(action_name)
	var action_event = action_events[0]

	var action_keycode = OS.get_keycode_string(action_event.physical_keycode)

	button.text = "%s" % action_keycode

func _on_button_toggled(toggled: bool) -> void:
	if toggled:
		button.text = "Press any key..."
		set_process_unhandled_key_input(toggled)
	else:
		set_text_for_key()