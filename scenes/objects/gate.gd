extends StaticBody2D

signal body_entered(body)
signal body_exited(body)

func _on_entry_body_entered(body):
	body_entered.emit(body)

func _on_entry_body_exited(body):
	body_exited.emit(body)
