extends Node
@onready var game: Game = $Game

func _ready() -> void:
	game.start_game()
