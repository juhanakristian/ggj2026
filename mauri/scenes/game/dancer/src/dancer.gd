class_name Dancer extends Node3D
## Dancer 


@onready var animated_sprite_3d: AnimatedSprite3D = $AnimatedSprite3D

func _ready() -> void:
	animated_sprite_3d.stop()
	animated_sprite_3d.frame = 0

func set_frame(frame : int):
	#print("Dancer::set_frame -> prev:%s new:%s" % [animated_sprite_3d.frame, frame])
	animated_sprite_3d.frame = frame

func _on_note_mask_updated(note_mask: int) -> void:
	set_frame(note_mask)
