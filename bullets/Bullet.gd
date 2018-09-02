extends Area2D

signal rocket_move

export (int) var speed
export (int) var damage
export (float) var lifetime
export (float) var drop_rate
var SmokeTrail = load("res://tracks/SmokeTrail.tscn")

var can_smoke = true
var velocity = Vector2()

func start(_position, _direction):
	position = _position
	rotation = _direction.angle()
	$Lifetime.wait_time = lifetime
	$Lifetime.start()
	velocity = _direction * speed
	
func _process(delta):
	position += velocity * delta
	if can_smoke:
		can_smoke = false
		$DropRate.wait_time = drop_rate
		$DropRate.start()
		emit_signal('rocket_move', SmokeTrail, $Smoke.global_position, Vector2(1, 0).rotated($Smoke.global_rotation))
	
func explode():
	queue_free()
	
func _on_Bullet_body_entered(body):
	explode()
	if body.has_method('take_damage'):
		body.take_damage(damage)
		
func _on_Lifetime_timeout():
	explode()

func _on_DropRate_timeout():
	can_smoke = true
