class_name MainMenu
extends Control

@export var start_button: Button
@export var settings_button: Button
@export var quit_button: Button
@export var main_scene: PackedScene


func _ready():
	start_button.button_down.connect(_on_start_button_down)
	settings_button.button_down.connect(_on_settings_button_down)
	quit_button.button_down.connect(_on_quit_button_down)

func _on_start_button_down():
	get_tree().change_scene_to_packed(main_scene)

func _on_settings_button_down():
	pass

func _on_quit_button_down():
	get_tree().quit()