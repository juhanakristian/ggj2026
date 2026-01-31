class_name Dancer extends Node3D
@onready var animated_sprite_3d: AnimatedSprite3D = $AnimatedSprite3D



func _ready() -> void:
	animated_sprite_3d.stop()
	animated_sprite_3d.frame = 1


func _on_note_controller_mask_updated(note_mask: int) -> void:
	animated_sprite_3d.frame = note_mask
