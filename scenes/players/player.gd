extends Node2D


const speed = 200
# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector2(100,100) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	position += direction * 100 * delta
	
	if Input.is_action_pressed("Primary"):
		print('shoot laser')
	if Input.is_action_pressed("Secondary"):
		print('shoot grenade')
