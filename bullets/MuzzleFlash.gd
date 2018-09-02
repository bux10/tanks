extends Area2D

export (float) var lifetime

func _ready():
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func start(_position, _direction):
	position = _position
	rotation = _direction.angle()
	$Lifetime.wait_time = lifetime
	$Lifetime.start()

func _on_Timer_timeout():
	#print("time")
	queue_free()
