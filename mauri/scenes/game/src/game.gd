class_name Game extends Node

enum State {INIT, WAIT, RUN, END}
var state : State = State.INIT
@onready var game_camera: Camera3D = $GameCamera
@onready var game_ui: CanvasLayer = $GameUI

@export var curtain_operator : CurtainOperator
@onready var test_environment: Node3D = $Environment
@onready var music_player: AudioStreamPlayer3D = $MusicPlayer
@onready var level: Level = $Level
@onready var countdown_ui: CountdownUI = $CountdownUI
@onready var note_controller: NoteController = $NoteController
@onready var note_container: Node3D = $NoteContainer

@onready var reset_label: Label = $GameUI/ResetLabel
@onready var high_score_label: Label = $GameUI/HighScoreLabel

## Stores the high score
var high_score = 0

signal game_started()

func update_high_score(new_score) -> void:
	if new_score > high_score:
		high_score = new_score
	high_score_label.text = level.format_points(high_score) + " PTS"
		

## Sets processing flags
func set_processing(enabled : bool):
	set_process(enabled)
	set_process_input(enabled)

	
func enable_camera(enabled : bool) -> void:
	game_camera.visible = enabled
	game_camera.current = enabled
 
## Initialize with disabled processing, wait for start method
func _ready() -> void:
	#set_processing(false)
	enable_camera(false)
	game_ui.visible = false
	note_controller.lock_controller(true)
	note_container.visible = false
		
func _process(delta: float) -> void:
	match state:
		State.INIT:
			proc_init(delta)
		State.RUN:
			proc_run(delta)
		State.END:
			proc_end_state(delta)

func proc_init(_delta: float) -> void:
	pass

func proc_run(_delta: float) -> void:
	pass
	
func proc_end_state(_delta) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		print("Space was pressed, resetting the game state")
		level.reset()
		state = State.RUN
		start_game()

## Method used for launching the game
func start_game():
	enable_camera(true)
	level.reset_points()
	reset_label.visible = false
	await curtain_operator.fade_in(2.0).curtain_faded_in
	await countdown_ui.start_countdown(3.0)
	level.enable_level(true)
	state = State.RUN
	game_ui.visible = true
	note_container.visible = true
	level.visible = true
	note_controller.lock_controller(false)
	


func _on_music_player_finished() -> void:
	state = State.END
	level.enable_level(false)
	reset_label.visible = true

	note_container.visible = false
	game_ui.visible = true
	note_controller.lock_controller(true)
	update_high_score(level.points)
	level.visible = false
