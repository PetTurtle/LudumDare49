extends Node

var stack : Array
onready var loading_scene := preload("res://scenes/Loading.tscn")

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

func replace(ps : PackedScene, anim_player : AnimationPlayer = null):
	stack.pop_front()
	if anim_player:
		get_tree().get_root().set_disable_input(true)
		yield(anim_player, "animation_finished")
		get_tree().get_root().set_disable_input(false)
	stack.push_front(ps)
	get_tree().current_scene.queue_free()
	assert(get_tree().change_scene_to(loading_scene) == 0)
	yield(get_tree().create_timer(0.05), "timeout")
	assert(get_tree().change_scene_to(ps) == 0)
	
