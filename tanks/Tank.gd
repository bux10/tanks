extends KinematicBody2D

signal health_changed
signal dead
signal shoot
signal move

export (PackedScene) var Bullet
export (PackedScene) var MuzzleFlash
export (PackedScene) var Track
export (PackedScene) var Smoke
export (int) var speed
export (float) var rotation_speed
export (float) var gun_cooldown
export (int) var health
export (float) var drop_rate

var velocity = Vector2()
var can_shoot = true
var alive = true
var can_track = true


func _ready():
	$GunTimer.wait_time = gun_cooldown
	
func shoot():
	if can_shoot:
		can_shoot = false
		$GunTimer.start()
		var dir = Vector2(1, 0).rotated($Turret.global_rotation)
		var mf = MuzzleFlash.instance()
		add_child(mf)
		mf.start($Turret/Flash.global_position, dir)
		#var pos = Vector2($Turret/Muzzle.global_position.x - 200, $Turret/Muzzle.global_position.y - 200)
		emit_signal('shoot', Bullet, Smoke, $Turret/Muzzle.global_position, dir)



func control(delta):
	pass
	
func _physics_process(delta):
	if not alive:
		return
	control(delta)
	move_and_slide(velocity)
	if can_track:
		can_track = false
		$DropRate.wait_time = drop_rate
		$DropRate.start()
		emit_signal('move', Track, $Body.global_position, Vector2(1, 0).rotated($Body.global_rotation))
	
	

func _on_GunTimer_timeout():
	can_shoot = true

func _on_DropRate_timeout():
	can_track = true