extends Node2D

var tutorials = "../../Player_frog/HUD/UI/Keybinds"
var isShowingMove : bool = false
var isShowingCroak : bool = false
var isShowingJump : bool = false

@onready var level_manager = $"/root/Level_manager"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isShowingMove:
		hide_prompt_on_press("move_left")
		hide_prompt_on_press("move_right")
	if isShowingCroak:
		hide_prompt_on_press("croak")
	if isShowingJump:
		hide_prompt_on_press("jump")

	
func update_prompt(prompt, state):
	var prompt_node = get_node(str(tutorials + "/" + prompt))
	if state:
		prompt_node.show()
		prompt_node.play()
	else:
		prompt_node.hide()
		prompt_node.stop()
		
func hide_prompt_on_press(prompt):
	if Input.is_action_just_pressed(prompt):
		update_prompt(prompt, false)
		Global.set("tutorial_" + prompt, false)


func _on_move_body_entered(body):
	if body is Player:
		update_prompt("move_left", Global.tutorial_move_left)
		update_prompt("move_right", Global.tutorial_move_right)
		isShowingMove = true

func _on_croak_body_entered(body):
	if body is Player:
		update_prompt("croak", Global.tutorial_croak)
		isShowingCroak = true

func _on_jump_body_entered(body):
	if body is Player:
		update_prompt("jump", Global.tutorial_jump)
		isShowingJump = true
