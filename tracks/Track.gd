extends Node2D


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func start(_position, _direction):
	position = _position
	rotation = _direction.angle()
	$Lifetime.start()
	

func _on_Lifetime_timeout():
	queue_free()
