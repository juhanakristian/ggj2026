class_name LevelData extends Resource

@export_multiline var notes_json : String

class NoteEvent:
	var note: String
	# seconds
	var start_time: float
	var end_time: float

	func _init(note: String, start_time: float, end_time: float):
		self.note = note
		self.start_time = start_time
		self.end_time = end_time

class NoteCheckResult:
	var is_correct: bool
	var timedelta: float

	func _init(is_correct: bool, timedelta: float):
		self.is_correct = is_correct
		self.timedelta = timedelta

func init_level() -> void:
	var parsed_data = JSON.parse_string(notes_json)

	
func get_note_data(note: String) -> Array[NoteEvent]:
	return []

func do_note_check(note: String, time: float) -> NoteCheckResult:
	return NoteCheckResult.new(false, 0)
