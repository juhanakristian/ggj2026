class_name Level extends Node3D

@export var level_data: LevelData
@export var units_per_second: int
@export var music_player: AudioStreamPlayer3D
const NOTE_INDICATOR = preload("uid://d4mag1cos3fya")

@onready var note_1: Sprite3D = $"../NoteContainer/NOTE1"
@onready var note_2: Sprite3D = $"../NoteContainer/NOTE2"
@onready var note_3: Sprite3D = $"../NoteContainer/NOTE3"
@onready var note_4: Sprite3D = $"../NoteContainer/NOTE4"

@onready var points_label: Label = $"../GameUI/PointsLabel"

const NOTE1 = "c"
const NOTE2 = "d"
const NOTE3 = "e"
const NOTE4 = "f"

var level_notes: Array[String] = [NOTE1,NOTE2,NOTE3,NOTE4]
var note_sprites: Dictionary[String, Sprite3D] = {}
var current_time: float = 0

const MAX_RECEIVED_POINTS = 1000

var points: int = 0

var original_y = 0

func format_points(value: int) -> String:
	var s = "00000" + str(value)
	return s.substr(s.length() - 5, 5)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	original_y = self.position.y
	# Load level data
	level_data.init_level()

	note_sprites = {
		NOTE1: note_1,
		NOTE2: note_2,
		NOTE3: note_3,
		NOTE4: note_4,
	}

	# Create lanes and "note" objects
	var note_index = 0
	for note in level_notes:
		var data = level_data.get_note_data(note)
		for event in data:
			print(event)
			var node: Node3D = NOTE_INDICATOR.instantiate()
			self.add_child(node)
			node.position.x = note_index * 2
			node.position.y = event.start_time * units_per_second
		note_index += 1
		
	set_process(false)
	
func reset() -> void:
	current_time = 0
	self.position.y = original_y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	current_time += delta
	self.position.y -= delta * float(units_per_second)

	# print("Current time: " + str(current_time))
	# print("Music time: " + str(music_player.get_playback_position()))
	# print("POINTS: " + str(points))

func enable_level(enable):
	set_process(enable)
	if enable:
		music_player.play()

## Resets points and updates the label
func reset_points() -> void:
	points = 0
	update_point_label_text()

func _on_note_controller_note_pressed(note: String) -> void:
	var result = level_data.do_note_check(note, current_time) # latency hack
	var sprite = note_sprites[note]
	if result.note_event:
		#print("Note time: " + str(result.note_event.start_time))
		points += (1.0 - abs(result.timedelta)) * MAX_RECEIVED_POINTS
		sprite.modulate = Color(0, 1, 0)
	elif abs(result.timedelta) < 0.150:
		points += (1.0 - abs(result.timedelta)) * MAX_RECEIVED_POINTS / 2
		sprite.modulate = Color(1, 1, 0)
	else:
		sprite.modulate = Color(1, 0, 0)
		
	update_point_label_text()

## Updates the label's text
func update_point_label_text() -> void:
	points_label.text = format_points(points) + " PTS"



func _on_note_controller_note_released(note: String) -> void:
	var sprite = note_sprites[note]
	sprite.modulate = Color(1, 1, 1)
