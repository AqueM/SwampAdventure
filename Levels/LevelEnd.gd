extends Area2D

func _on_body_entered(body):
	if body is Player:
		body.show_end_screen()
