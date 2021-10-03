extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_tree_exiting():
	var position = get_parent().global_position
	var new_parent = get_parent().get_parent()
	get_parent().remove_child(self)
	new_parent.call_deferred("add_child", self)
	global_position = position
	
