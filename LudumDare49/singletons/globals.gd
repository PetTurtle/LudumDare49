extends Node

signal score_changed

var player: RigidBody2D
var score := 0
var effects: Node2D
var audio: Node2D

func add_score(amount: int):
	score += amount
	emit_signal("score_changed")


func reset():
	score = 0
	effects = null
	audio = null
