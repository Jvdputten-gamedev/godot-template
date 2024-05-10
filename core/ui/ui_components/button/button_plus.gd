extends Button
class_name ButtonPlus

@export var hover_sound: AudioStreamPlayer
@export var click_sound: AudioStreamPlayer

func _ready():
	mouse_entered.connect(_on_mouse_entered)
	pressed.connect(_on_pressed)

func _on_mouse_entered():
	hover_sound.play()

func _on_pressed():
	click_sound.play()
