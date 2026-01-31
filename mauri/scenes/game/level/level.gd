class_name Level extends Node3D

@export var level_data: LevelData
@export var units_per_second: int
@export var music_player: AudioStreamPlayer3D
const NOTE_INDICATOR = preload("uid://d4mag1cos3fya")

const NOTE1 = "c"
const NOTE2 = "d"
const NOTE3 = "e"
const NOTE4 = "f"

var level_notes: Array[String] = [NOTE1,NOTE2,NOTE3,NOTE4]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Load level data
	level_data.init_level()

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.position.y -= delta * units_per_second

func enable_level(enable):
	set_process(enable)
	if enable:
		music_player.play()
