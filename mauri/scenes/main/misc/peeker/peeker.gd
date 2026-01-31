extends Node3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var wait_time_sec : float = 3.0


## Wait for given time before starting the animation
func _ready() -> void:
	await get_tree().create_timer(wait_time_sec).timeout
	animation_player.play("Peek")
	
