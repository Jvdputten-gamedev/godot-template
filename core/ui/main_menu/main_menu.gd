class_name MainMenu
extends Control

@export var start_button: Button
@export var options_button: Button
@export var quit_button: Button

@export var options_menu: OptionsMenu
@export var main_menu_container: MarginContainer

@export var main_scene: PackedScene




func _ready():
	start_button.button_down.connect(_on_start_button_down)
	options_button.button_down.connect(_on_options_button_down)
	quit_button.button_down.connect(_on_quit_button_down)
	options_menu.exit_options_menu.connect(_on_exit_options_menu)


func _on_start_button_down():
	SceneManager.fade(main_scene)

func _on_options_button_down():
	main_menu_container.visible = false
	options_menu.show()

func _on_quit_button_down():
	get_tree().quit()

func _on_exit_options_menu() -> void:
	main_menu_container.visible = true
