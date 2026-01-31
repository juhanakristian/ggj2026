class_name NoteController extends Node
## Controller for players

## Signal emitted when the c
signal mask_updated(note_mask : int)

#signal note_pressed()
#signal note_released()

var current_mask = 0

## Player Id is used for finding the correct controls of the user
@export var player_id : int = 1

var action_note_1 = ""
var action_note_2 = ""
var action_note_3 = ""
var action_note_4 = ""

func _ready() -> void:
	action_note_1 = "p%s_note_1" % player_id
	action_note_2 = "p%s_note_2" % player_id
	action_note_3 = "p%s_note_3" % player_id
	action_note_4 = "p%s_note_4" % player_id
	
## Processes the mask and emits signal when change is detected
func _process_mask():
	var mask : int = 0
	if Input.is_action_pressed(action_note_1):
		mask |= 1
	if Input.is_action_pressed(action_note_2):
		mask |= 2
	if Input.is_action_pressed(action_note_3):
		mask |= 4
	if Input.is_action_pressed(action_note_4):
		mask |= 8
		
	if current_mask != mask:
		print(mask)
		current_mask = mask
		mask_updated.emit(mask)

## Processes press release events for keys
func _process_press_release():
	pass
	
	
func _process(delta: float) -> void:	
	_process_press_release()
	_process_mask()

	
	
