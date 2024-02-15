extends Node2D
var tutorials = "Player_frog/Keybinds"
var isShowingMove : bool = false
var isShowingCroak : bool = false
var isShowingJump : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node(tutorials+ "/D").hide()
	get_node(tutorials+ "/A").hide()
	get_node(tutorials+ "/E").hide()
	get_node(tutorials+ "/Space").hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isShowingMove:
		hide_prompt_on_press("A", "move_left")
		hide_prompt_on_press("D", "move_right")
	if isShowingCroak:
		hide_prompt_on_press("E", "croak")
	if isShowingJump:
		hide_prompt_on_press("Space", "jump")

	
func update_prompt(prompt, state):
	var prompt_node = get_node(str(tutorials + "/" + prompt))
	if state:
		prompt_node.show()
		prompt_node.play()
	else:
		prompt_node.hide()
		prompt_node.stop()
		
func hide_prompt_on_press(prompt, input):
	if Input.is_action_just_pressed(str(input)):
		update_prompt(prompt, false)

func _on_move_body_entered(body):
	if body is Player && not isShowingMove:
		update_prompt("A", true)
		update_prompt("D", true)
		isShowingMove = true

func _on_croak_body_entered(body):
	if body is Player && not isShowingCroak:
		update_prompt("E", true)
		isShowingCroak = true

func _on_jump_body_entered(body):
	if body is Player && not isShowingJump:
		update_prompt("Space", true)
		isShowingJump = true
