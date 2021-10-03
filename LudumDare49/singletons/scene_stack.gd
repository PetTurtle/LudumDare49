extends Node

var stack : Array

func _ready():
	stack.push_front(load((ProjectSettings.get_setting("application/run/main_scene"))))

func push(ps : PackedScene, anim_player : AnimationPlayer = null):
	if anim_player:
		get_tree().get_root().set_disable_input(true)
		yield(anim_player, "animation_finished")
		get_tree().get_root().set_disable_input(false)
	stack.push_front(ps)
	assert(get_tree().change_scene_to(ps) == 0)

func pop(anim_player : AnimationPlayer = null):
	if anim_player:
		get_tree().get_root().set_disable_input(true)
		yield(anim_player, "animation_finished")
		get_tree().get_root().set_disable_input(false)
	stack.pop_front()
	assert(get_tree().change_scene_to(stack.front()) == 0)
