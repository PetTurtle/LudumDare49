extends Node

var in_range: Array
var radars: Array

onready var aStar := AStar2D.new()
onready var signal_line_scene := preload("res://objects/SignalLine/SignalLine.tscn")


func _physics_process(_delta):
	if Globals.player == null:
		return
	
	aStar.clear()
	in_range.clear()
	_clear_lines()
	
	for i in range(radars.size()):
		aStar.add_point(i, radars[i].global_position)
		if radars[i].can_see_player():
			in_range.append(i)
	
	for x in range(radars.size()):
		for y in range(radars.size()):
			if x != y:
				if radars[x].can_see(radars[y], false):
					aStar.connect_points(x, y)

	for i in range(1, radars.size()):
		var path := aStar.get_id_path(0, i)
		radars[i].active = path.size() > 0 and path[0] == 0

	for s_id in in_range:
		if radars[s_id].can_see_player():
			var path := aStar.get_id_path(s_id, 0)
			if path.size() > 0 and path[path.size() - 1] == 0:
				_create_line(Globals.player, radars[s_id])
				for i in range(path.size() - 1):
					_create_line(radars[path[i]], radars[path[i+1]])
				Globals.player.set_radar_signal(true)
				return
	
	# cant see player
	Globals.player.set_radar_signal(false)


func add_radar(radar: Node2D):
	radars.append(radar)

func remove_radar(radar: Node2D):
	var id := radars.find(radar)
	if id != -1:
		radars.remove(id)

func clear():
	radars.clear()
	_clear_lines()

func _clear_lines():
	for child in get_children():
		child.queue_free()

func _create_line(a: Node2D, b: Node2D):
	var line := signal_line_scene.instance()
	var points := PoolVector2Array()
	points.append(a.global_position)
	points.append(b.global_position)
	line.points = points
	add_child(line)
