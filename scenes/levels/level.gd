extends Node2D

var logo
# Called when the node enters the scene tree for the first time.
func _ready():
	logo = $Logo


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if logo.position.x > 1000:
		logo.position.x = 0

