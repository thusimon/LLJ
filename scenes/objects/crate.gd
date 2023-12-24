extends ItemContainer

@onready var init_direction: Vector2 = Vector2.DOWN.rotated(rotation)

var is_hit = false

func hit():
	if not is_hit:
		super.hit()
		is_hit = true
		$UpSprite.hide()
		var pos = $SpawnPosition.global_position
		for i in range(3):
			var direction = init_direction.rotated(randf_range(-PI/2, PI/2))
			open.emit(pos, direction)
