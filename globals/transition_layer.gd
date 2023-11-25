extends CanvasLayer

func _ready():
	$ColorRect.modulate = 0

func transition_to_scene(scene: String):
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(scene)
	$AnimationPlayer.play_backwards("fade_out")
