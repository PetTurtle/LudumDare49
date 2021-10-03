extends Area2D


func _ready():
	Globals.add_goal()


func _process(delta):
	global_rotation = 0


func _on_Goal_body_entered(body):
	body.power_up()
	Globals.add_score(5)
	Globals.goal_reached()
	queue_free()
