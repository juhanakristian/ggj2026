extends Node3D
@onready var note_event_log: RichTextLabel = $CanvasLayer/NoteEventLog

func log_event(event_line : String) -> void:
	note_event_log.append_text(event_line+"\n")

func _on_note_controller_note_pressed(note: String) -> void:
	log_event("Note pressed:%s" % note)

func _on_note_controller_note_released(note: String) -> void:
	log_event("Note released:%s" % note)

func _on_note_controller_note_mask_updated(note_mask: int) -> void:
	log_event("Note mask updated:%s" % note_mask)
