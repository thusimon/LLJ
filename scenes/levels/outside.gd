extends LevelBase

func _on_gate_body_entered(_body):
	var tween = create_tween()
	tween.tween_property($Player, 'speed', 0, 0.5)
	TransitionLayer.transition_to_scene("res://scenes/levels/inside.tscn")

func _on_gate_body_exited(_body):
	pass
