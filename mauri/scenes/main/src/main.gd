class_name Main extends Node

enum State {INIT, INTRO, WAIT, GAME } 
var state : State = State.INIT


@onready var game: Game = $Game
@export var curtain_operator : CurtainOperator

func _ready() -> void:
	curtain_operator.fade_dark()
	
func _process(delta: float) -> void:
	match state:
		State.INIT:
			proc_init(delta)
		State.INTRO:
			proc_intro(delta)
		State.WAIT:
			proc_wait_state(delta)
				

func proc_init(delta : float) -> void:
	print("Initializing, moving to intro state..")
	state = State.INTRO	
	
	
	
func proc_intro(delta : float) -> void:
	curtain_operator.fade_in(1.0)
	state = State.WAIT
	

func proc_wait_state(delta) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		print("Space was pressed, activating the game state")
		await curtain_operator.fade_out().curtain_faded_out
		state = State.GAME
		game.start_game()		


	
	
