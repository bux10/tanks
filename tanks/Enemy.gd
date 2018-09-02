extends "res://tanks/Tank.gd"

onready var parent = get_parent()

export (float) var turrent_speed = 1.0
export (int) var detect_radius = 400

var speed = 1
var target = null

func _ready():
	var circle = CircleShape2D.new()
	$DetectRadius/CollisionShape2D.shape = circle
	$DetectRadius/CollisionShape2D.shape.radius = detect_radius

func control(delta):
	if $LookAhead1.is_colliding() or $LookAhead2.is_colliding() or $LookAhead3.is_colliding():
		speed = lerp(speed, 0, 0.1) #ramp speed down to 0
	else:
		speed = lerp(speed, max_speed, 0.05) #ramp up speed to max_speed

	if parent is PathFollow2D:
		parent.set_offset(parent.get_offset() + speed * delta)
		position = Vector2()
	else:
		#other movement code
		pass

func _process(delta):
	if target:
		var target_dir = (target.global_position - global_position).normalized()
		var current_dir = Vector2(1, 0).rotated($Turret.global_rotation)
		$Turret.global_rotation = current_dir.linear_interpolate(target_dir, turrent_speed * delta).angle()
		if target_dir.dot(current_dir) > 0.9:
			shoot()

func _on_DetectRadius_body_entered(body):
		target = body


func _on_DetectRadius_body_exited(body):
	if body == target:
		target = null
		