extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_entry_body_entered(body):
	print('entered: ', body)


func _on_entry_body_exited(body):
	print('exit: ', body)
