extends Node2D
class_name Gem

signal collected_gem


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	if body is Player:
		emit_signal("collected_gem")
		queue_free()
		
