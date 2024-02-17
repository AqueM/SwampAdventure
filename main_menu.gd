extends Node2D
var level_manager = preload("res://Levels/level_manager.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer/Credits.visible = false
	$MarginContainer/Title.visible = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_btn_pressed():
	$StartSound.play()
	$Transitions.transition()
	await $StartSound.finished



func _on_credits_btn_pressed():
	$StartSound.play()
	$MarginContainer/Credits.visible = true
	$MarginContainer/Title.visible = false


func _on_exit_btn_pressed():
	get_tree().quit()


func _on_back_btn_pressed():
	$StartSound.play()
	$MarginContainer/Credits.visible = false
	$MarginContainer/Title.visible  = true


func _on_credits_meta_clicked(meta):
	OS.shell_open(str(meta))


func _on_transitions_transitioned():
	get_tree().change_scene_to_packed(level_manager)
