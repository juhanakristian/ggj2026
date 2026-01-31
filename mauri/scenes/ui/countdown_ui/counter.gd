class_name CountdownUI extends CanvasLayer
## Counter counts down to zero and emits signel

@onready var countdown_label: RichTextLabel = $CountdownLabel
@onready var countdown_timer: Timer = $CountdownTimer

## BBCode effect amplitude
@export var effect_amp:=100

## BBCode effect frequency
@export var effect_freq:=10

@export_category("Message")
@export var show_message : bool = true
@export var message_time_sec : float = 1.0 
## Message shown after timer
@export var message : String = "Go"

## Emitted when the countdown is finished
signal countdown_finished()

func _ready() -> void:
	enable_countdown_ui(false)
	countdown_timer.timeout.connect(_on_countdown_timer_timeout)
	
func enable_countdown_ui(enabled : bool):
	visible = enabled
	set_process(enabled)
	
## Sets the label's text as time in seconds (rounded)
func set_label_time(time_sec : float) -> void:
	var time_int = ceili(time_sec)
	countdown_label.text = "[wave amp=%s freq=%s]%s[/wave]" % [
		effect_amp, effect_freq, time_int
	]


## Sets the label text directly (including the effect)
func set_label_text(text : String) -> void:
	countdown_label.text = "[wave amp=%s freq=%s]%s[/wave]" % [
		effect_amp, effect_freq, text
	]

## Starts the countdown from provided time_sec
func start_countdown(time_sec : float):
	enable_countdown_ui(true)
	set_label_time(time_sec)
	countdown_timer.start(time_sec)	
	return countdown_finished
	
## Process called only when the UI is active, updates the countdown label
func _process(_delta: float) -> void:
	if countdown_timer.time_left > 0:
		set_label_time(countdown_timer.time_left)

## Handles the countdown timer timeout
## If message enabled, emits the message and waits for defined time
## When finished, emits the signal countdown_finished and disables the counter
func _on_countdown_timer_timeout() -> void:
	if show_message:
		set_label_text(message)
		await get_tree().create_timer(message_time_sec).timeout
	
	countdown_finished.emit()
	enable_countdown_ui(false)
	
