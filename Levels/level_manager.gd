extends Node2D

signal score_changed(count : int)

var level_number = 1
var is_switching_level = false
var continue_level : bool = false
var end_level : bool = false
var gems_collected = 0
var score = 0


@onready var player = $Player_frog


func _process(delta):
	if Input.is_action_just_pressed("next"):
		$Transitions.transition()
	if Input.is_action_pressed("jump"):
		if continue_level:
			$Transitions.transition()
		if end_level:
			score += gems_collected
			gems_collected = 0
			$Transitions.transition()
	
	
func _ready():
	load_level(level_number)
	

func load_level(level):
	var level_path = "res://Levels/level_" + str(level) + ".tscn"
	var level_scene = load(level_path)
	var level_instance = level_scene.instantiate()
	$CurrentScene.add_child(level_instance)
	is_switching_level = false

func switch_level():
	if is_switching_level:
		return

	is_switching_level = true
	if not continue_level:
		level_number += 1
	#	
		if level_number > 2:
			level_number = 1

		$CurrentScene.get_child(0).queue_free()
		load_level(level_number)
	else:
		get_tree().reload_current_scene()

func _on_transitions_transitioned():
	switch_level()

func _on_player_frog_died():
	$Player_frog/HUD/DeathScreen.visible = true
	continue_level = true
	
func _on_player_frog_end_level():
	end_level = true

func collected_gem():
	gems_collected += 1
	score = gems_collected
	score_changed.emit(gems_collected)




