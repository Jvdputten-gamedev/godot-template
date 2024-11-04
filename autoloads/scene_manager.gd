extends Node

# Export variables
@export var animation_player: AnimationPlayer

@export var main_menu_scene: PackedScene
@export var credits_scene: PackedScene
@export var main_scene: PackedScene

## Onready variables

# Class variables
var transition_data: Resource = null

# Signals
signal transition_started
signal transition_in_complete
signal transition_out_complete

enum TransitionType {FADE, FADE_WHITE}

func ensure_node_ready(node: Node) -> void:
	if not node.is_inside_tree():
		await node.tree_entered
	if not node.is_node_ready():
		await node.ready

func get_animation_name(type: TransitionType) -> String:
	match type:
		TransitionType.FADE:
			return "fade"
		TransitionType.FADE_WHITE:
			return "fade_white"
	return "fade"

func transition(type: TransitionType, scene:PackedScene, data: Resource = null):
	var animation_name = get_animation_name(type)
	animation_player.play(animation_name + "_out")

	await animation_player.animation_finished
	transition_in_complete.emit()

	if data:
		transition_data = data
	else:
		transition_data = null
	
	var error = get_tree().change_scene_to_packed(scene)
	if error != OK:
		push_error("Failed to change scene")
		return

	await get_tree().process_frame

	var new_scene_root = get_tree().current_scene

	await ensure_node_ready(new_scene_root)
	init_new_scene_root(new_scene_root)

	animation_player.play(animation_name + "_in")
	await animation_player.animation_finished
	transition_out_complete.emit()

func fade(scene:PackedScene, data: Resource = null):
	transition(TransitionType.FADE, scene, data)

func init_new_scene_root(new_scene_root: Node):
	if new_scene_root.has_method("set_transition_data"):
		new_scene_root.set_transition_data(transition_data)

	if new_scene_root.has_method('setup'):
		new_scene_root.setup()

func get_transition_data():
	return transition_data


func to_main_menu():
	fade(main_menu_scene)
	
func to_main_scene():
	fade(main_scene)

func to_credits():
	fade(credits_scene)
