class_name Game extends Node

enum State {INIT, WAIT, RUN, END}
@onready var game_camera: Camera3D = $GameCamera

@export var curtain_operator : CurtainOperator
@onready var test_environment: Node3D = $Environment
@onready var music_player: AudioStreamPlayer3D = $MusicPlayer
@onready var level: Level = $Level
@onready var countdown_ui: CountdownUI = $CountdownUI

signal game_started()

## Sets processing flags
func set_processing(enabled : bool):
	set_process(enabled)
	set_process_input(enabled)
	
func enable_camera(enabled : bool) -> void:
	game_camera.visible = enabled
	game_camera.current = enabled
 
## Initialize with disabled processing, wait for start method
func _ready() -> void:
	set_processing(false)
	enable_camera(false)

## Method used for launching the game
func start_game():
	enable_camera(true)
	await curtain_operator.fade_in(2.0).curtain_faded_in
	await countdown_ui.start_countdown(3.0)
	level.enable_level(true)
