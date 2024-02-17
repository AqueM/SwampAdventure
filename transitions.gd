extends CanvasLayer
signal transitioned

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func transition():
	$AnimationPlayer.play("fade_to_dark")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade_to_dark":
		emit_signal("transitioned")
		$AnimationPlayer.play("dark_to_fade")
