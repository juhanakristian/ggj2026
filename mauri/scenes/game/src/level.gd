class_name Level extends Resource

@export_multiline var notes_json : String

func init_level() -> void:
	var parsed_data = JSON.parse_string(notes_json)
	# Do the magic here

	
