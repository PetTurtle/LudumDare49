extends Node2D


onready var transition: AnimationPlayer = $UI/Transition
onready var game_scene: PackedScene = preload("res://scenes/game.tscn")

func _init():
	randomize()

func _on_Play_pressed():
	transition.play("Close")
	SceneStack.push(game_scene, transition)


func _on_Exit_pressed():
	get_tree().quit()
