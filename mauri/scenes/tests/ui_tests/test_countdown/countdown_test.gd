extends Node3D
@onready var countdown_ui: CountdownUI = $CountdownUI

func _ready() -> void:
	countdown_ui.start_countdown(3)
