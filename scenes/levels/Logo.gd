extends Sprite2D


var pos = Vector2(100,100)
const speed = 200
# Called when the node enters the scene tree for the first time.
func _ready():
	position = pos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += speed * delta
	rotation_degrees += 100 * delta
