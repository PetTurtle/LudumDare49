extends Node2D

onready var pause_menu := $UI/Paused
onready var over_menu := $UI/GameOver
onready var objects: Node2D = $Objects
onready var transition: AnimationPlayer = $UI/Transition
onready var screen_effect := $UI/ScreenEffect
onready var game_scene: PackedScene = load("res://scenes/game.tscn")


func _input(event):
	if event.is_action_pressed("pause"):
		pause_menu.visible = !pause_menu.visible
		if pause_menu.visible:
			get_tree().paused = true
		else:
			get_tree().paused = false


func _exit_tree():
	Radars.clear()
	Globals.reset()


func _on_Exit_pressed():
	get_tree().paused = false
	transition.play("Close")
	SceneStack.pop(transition)


func _on_Resume_pressed():
	pause_menu.visible = false
	get_tree().paused = false


func _on_Player_died():
	yield(get_tree().create_timer(1), "timeout")
	over_menu.visible = true


func _on_Restart_pressed():
	transition.play("Close")
	SceneStack.replace(game_scene, transition)
