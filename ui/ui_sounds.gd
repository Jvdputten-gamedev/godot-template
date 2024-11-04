extends Node


@export var click_sound: AudioStreamPlayer
@export var hover_sound: AudioStreamPlayer

func _enter_tree():
	print("connecting to tree")
	get_tree().node_added.connect(connect_ui_element)

func connect_ui_element(node):
	print("connecting ui element ", node)
	if node is Button:
		node.mouse_entered.connect(func(): hover_sound.play())
		node.pressed.connect(func(): click_sound.play())

	if node is Slider:
		node.mouse_entered.connect(func(): hover_sound.play())
		node.drag_started.connect(func(): click_sound.play())		
		node.drag_ended.connect(_on_range_drag_ended)		

	if node is TabContainer:
		node.tab_hovered.connect(_on_tab_hovered)
		node.tab_selected.connect(_on_tab_clicked)


func _on_range_drag_ended(_value_changed: bool):
	if _value_changed:
		click_sound.play()

func _on_tab_clicked(_tab: int):
	click_sound.play()

func _on_tab_hovered(_tab: int):
	hover_sound.play()
