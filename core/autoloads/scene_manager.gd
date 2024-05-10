extends Node

@export var animation_player: AnimationPlayer

enum TransitionType {FADE}

func transition(type: TransitionType, scene:PackedScene):
	match type:
		TransitionType.FADE:
			fade(scene)

func fade(scene:PackedScene):
	animation_player.play("fade_out")
	await animation_player.animation_finished
	get_tree().change_scene_to_packed(scene)
	animation_player.play("fade_in")

