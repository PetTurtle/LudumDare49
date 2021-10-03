extends CPUParticles2D

export(float) var emit_time := 1.0

func _ready():
	var timer := Timer.new()
	add_child(timer)
	timer.connect("timeout", self, "on_timeout")
	timer.wait_time = emit_time
	timer.one_shot = true
	timer.start()
	emitting = true
	

func on_timeout():
	queue_free()
