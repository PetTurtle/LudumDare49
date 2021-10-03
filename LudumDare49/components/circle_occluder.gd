class_name CircleOccluder
extends LightOccluder2D

func _init(radius: int):
	var polygons := PoolVector2Array()
	for i in range(0, 360, 360/8):
		var vector := Vector2(radius*cos(PI * i / 180.0), radius*sin(PI * i / 180.0))
		polygons.append(vector)
		
	occluder = OccluderPolygon2D.new()
	occluder.polygon = polygons
	

