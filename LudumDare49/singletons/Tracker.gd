extends Node

var tracked : Array

func add_node(node: Node2D):
	tracked.append(node)

func remove_node(node: Node2D):
	var id := tracked.find(node)
	if id != -1:
		tracked.remove(id)

func clear():
	tracked.clear()
