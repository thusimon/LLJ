extends LevelBase

#var inside_next_scene: PackedScene = preload("res://scenes/levels/outside.tscn")

func _on_exit_body_entered(_body):
	var tween = create_tween()
	tween.tween_property($Player, 'speed', 0, 0.5)
	TransitionLayer.transition_to_scene("res://scenes/levels/outside.tscn")
