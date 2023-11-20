extends LevelBase


func _on_exit_body_entered(_body):
	var tween = create_tween()
	tween.tween_property($Player, 'speed', 0, 0.5)
