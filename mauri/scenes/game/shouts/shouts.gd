extends Node

@onready var sample_player: AudioStreamPlayer3D = $AudioStreamPlayer3D

var shout_samples: Array[AudioStream] = [
	preload("res://assets/audio/shouts/01.mp3"),
	preload("res://assets/audio/shouts/02.mp3"),
	preload("res://assets/audio/shouts/03.mp3"),
	preload("res://assets/audio/shouts/04.mp3"),
	preload("res://assets/audio/shouts/05.mp3"),
	preload("res://assets/audio/shouts/06.mp3"),
	preload("res://assets/audio/shouts/07.mp3"),
	preload("res://assets/audio/shouts/08.mp3"),
	preload("res://assets/audio/shouts/09.mp3"),
	preload("res://assets/audio/shouts/10.mp3")
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
				
	


func _on_note_controller_note_mask_updated(note_mask: int) -> void:
	if note_mask == 0:
		return
	
	var index = note_mask % 10
	
	sample_player.stream = shout_samples[index]
	sample_player.play()
