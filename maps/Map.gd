extends Node2D


func _ready():
	Input.set_custom_mouse_cursor(load("res://assets/UI/crossair_black.png"), Input.CURSOR_ARROW, Vector2(16, 16))
	set_camera_limits()
	
func set_camera_limits():
		var map_limits = $Ground.get_used_rect()
		var map_cellsize = $Ground.cell_size
		$Ground/Player/Camera2D.limit_left = map_limits.position.x * map_cellsize.x
		$Ground/Player/Camera2D.limit_right = map_limits.end.x * map_cellsize.x
		$Ground/Player/Camera2D.limit_top = map_limits.position.y * map_cellsize.y
		$Ground/Player/Camera2D.limit_bottom = map_limits.end.y * map_cellsize.y

func _on_Tank_shoot(bullet, _position, _direction):
	var b = bullet.instance()
	add_child(b)
	b.start(_position, _direction)
	b.connect("rocket_move", self, "_on_Rocket_move")
	
func _on_Tank_move(track, _position, _direction):
	var t = track.instance()
	add_child(t)
	t.start(_position, _direction)
	
func _on_Rocket_move(smoke, _position, _direction):
	var s = smoke.instance()
	add_child(s)
	s.start(_position, _direction)