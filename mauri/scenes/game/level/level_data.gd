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
		
	func _to_string() -> String:
		return self.note + " " + str(self.start_time)

var note_events: Array[NoteEvent] = []

class NoteCheckResult:
	var is_correct: bool
	var timedelta: float

	func _init(is_correct: bool, timedelta: float):
		self.is_correct = is_correct
		self.timedelta = timedelta

func init_level() -> void:
	var json = JSON.new()
	var err = json.parse(notes_json)

	if err != OK:
		push_error("Invalid JSON")
		return


	var data = json.data
	if data is not Array:
		push_error("Invalid JSON: expecting an array of values")
		return


	var result: Array[NoteEvent] = []
	for item in data:
		var note = item.get("key", "")
		var start_time = float(item.get("start_time", 0.0))
		var end_time = float(item.get("end_time", 0.0))
		result.append(NoteEvent.new(
			note, start_time, end_time
		))

	note_events = result

	
func get_note_data(note: String) -> Array[NoteEvent]:
	var result: Array[NoteEvent] = []
	for event in note_events:
		if event.note == note:
			result.append(event)

	return result

func do_note_check(note: String, time: float) -> NoteCheckResult:
	return NoteCheckResult.new(false, 0)
