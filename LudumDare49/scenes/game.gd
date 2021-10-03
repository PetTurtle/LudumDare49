extends Node2D

onready var pause_menu := $UI/Paused
onready var over_menu := $UI/GameOver
onready var win_menu := $UI/GameWon
onready var objects: Node2D = $Objects
onready var transition: AnimationPlayer = $UI/Transition
onready var screen_effect := $UI/ScreenEffect
onready var death_delay_timer := $DeathDelayTimer
onready var planets_bar := $UI/PlanetsBar
onready var game_scene: PackedScene = load("res://scenes/game.tscn")

func _ready():
	Globals.connect("goal_reached", self, "on_goal_reached")
	Globals.connect("goals_done", self, "on_goal_done")

func _input(event):
	if event.is_action_pressed("pause"):
		pause_menu.visible = !pause_menu.visible
		if pause_menu.visible:
			get_tree().paused = true
		else:
			get_tree().paused = false

func on_goal_reached():
	planets_bar.value = planets_bar.max_value - Globals.goals

func on_goal_done():
	win_menu.visible = true
	get_tree().paused = true

func _exit_tree():
	Radars.clear()
	Globals.reset()


func _on_Exit_pressed():
	pause_menu.visible = false
	get_tree().paused = false
	transition.play("Close")
	SceneStack.pop(transition)


func _on_Resume_pressed():
	pause_menu.visible = false
	get_tree().paused = false

func _on_Player_died():
	death_delay_timer.start()

func _on_Restart_pressed():
	pause_menu.visible = false
	get_tree().paused = false
	transition.play("Close")
	SceneStack.replace(game_scene, transition)

func _on_DeathDelayTimer_timeout():
	over_menu.visible = true


func _on_Continue_pressed():
	win_menu.visible = false
	get_tree().paused = false
