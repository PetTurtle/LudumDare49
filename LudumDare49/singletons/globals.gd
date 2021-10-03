extends Node

signal score_changed
signal goal_reached
signal goals_done

var goals := 0
var player: RigidBody2D
var score := 0
var effects: Node2D
var audio: Node2D

func add_score(amount: int):
	score += amount
	emit_signal("score_changed")

func add_goal():
	goals += 1

func goal_reached():
	goals -= 1
	emit_signal("goal_reached")
	if goals == 0:
		emit_signal("goals_done")

func reset():
	score = 0
	goals = 0
	player = null
	effects = null
	audio = null
