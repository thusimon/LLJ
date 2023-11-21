extends LevelBase

#var outside_next_scene: PackedScene = preload("res://scenes/levels/inside.tscn")

func _on_gate_body_entered(_body):
	var tween = create_tween()
	tween.tween_property($Player, 'speed', 0, 0.5)
	#get_tree().change_scene_to_packed(outside_next_scene)
	get_tree().change_scene_to_file("res://scenes/levels/inside.tscn")
	

func _on_gate_body_exited(_body):
	pass
