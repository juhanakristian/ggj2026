class_name NoteController extends Node
## Player controller for emitting note presses, releases and mask updates

## Signal emitted when the note mask is updated
signal note_mask_updated(note_mask : int)

## Emitted when note action is just pressed
signal note_pressed(note : String)

## Emitted when note action is just released
signal note_released(note : String)

var current_mask = 0

## Player Id is used for finding the correct controls of the user
@export var player_id : int = 1


var action_note_1 : String  = ""
var action_note_2 : String  = ""
var action_note_3 : String  = ""
var action_note_4 : String  = ""

## Setup the controller using the exported player id for finding correct mapping
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
		print("NoteController::_process_mask -> updated:%s" % mask)
		current_mask = mask
		note_mask_updated.emit(mask)

## Checks for notes being just pressed or released
func _process_press_release():
	# Emit signals for notes being just pressed
	if Input.is_action_just_pressed(action_note_1):
		note_pressed.emit(Level.NOTE1)
	if Input.is_action_just_pressed(action_note_2):
		note_pressed.emit(Level.NOTE2)
	if Input.is_action_just_pressed(action_note_3):
		note_pressed.emit(Level.NOTE3)
	if Input.is_action_just_pressed(action_note_4):
		note_pressed.emit(Level.NOTE4)
		
	## Emit signals for notest being just released
	if Input.is_action_just_released(action_note_1):
		note_released.emit(Level.NOTE1)
	if Input.is_action_just_released(action_note_2):
		note_released.emit(Level.NOTE2)
	if Input.is_action_just_released(action_note_3):
		note_released.emit(Level.NOTE3)
	if Input.is_action_just_released(action_note_4):
		note_released.emit(Level.NOTE4)
		
## Processes the actions
func _physics_process(_delta: float) -> void:	
	_process_press_release()
	_process_mask()

	
	
