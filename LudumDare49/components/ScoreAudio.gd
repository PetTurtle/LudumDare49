extends AudioStreamPlayer2D


func _ready():
	Globals.connect("score_changed", self, "on_score_changed")
	
func on_score_changed():
	play()
