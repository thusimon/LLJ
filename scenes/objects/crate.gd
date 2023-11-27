extends ItemContainer

var is_hit = false

func hit():
	if not is_hit:
		is_hit = true
		$UpSprite.hide()
		var pos = $SpawnPosition.global_position
		for i in range(3):
			var direction = Vector2(0, 1)
			direction = direction.rotated(randf_range(0, 2*PI))
			open.emit(pos, direction)
