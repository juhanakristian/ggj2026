class_name Curtain extends CanvasLayer

## Signal emitted when the curtain is faded-out
signal curtain_faded_out()

## Signal emitted when the curtain is beign faded in
signal curtain_faded_in()


@onready var fade_overlay_color_rect: ColorRect = $FadeOverlayColorRect
@export var fade_duration: float = 1.0 # Default fade duration
@export var fade_color: Color = Color(0, 0, 0) # Default fade color (black)

@export var curtain_operator : CurtainOperator

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	## Sets the operator
	curtain_operator.set_curtain(self)
	
	# Ensure the curtain is fully transparent and hidden initially.
	fade_overlay_color_rect.modulate = Color(fade_color.r, fade_color.g, fade_color.b, 0)  # Fully transparent
	fade_overlay_color_rect.hide()  # Hide the curtain when not in use





# Setter for the fade color
func set_fade_color(new_color: Color) -> void:
	fade_color = new_color
	fade_overlay_color_rect.modulate = fade_color  # Apply the new color to the ColorRect


# Fade In the curtain (from black to transparent)
func fade_in(duration: float = fade_duration) -> void:
	fade_overlay_color_rect.modulate = fade_color  # Set the fade color
	fade_overlay_color_rect.show()  # Make the ColorRect visible
	var tween = get_tree().create_tween()
	tween.finished.connect(_on_fade_in_finished)
	tween.tween_property(fade_overlay_color_rect, "modulate:a", 0, duration)  # Tween alpha to 0

## Handler for tween finished signal, from fade_in
func _on_fade_in_finished() -> void:
	curtain_faded_in.emit()

# Fade Out the curtain (from transparent to black)
func fade_out(duration: float = fade_duration) -> void:
	fade_overlay_color_rect.modulate = Color(fade_color.r, fade_color.g, fade_color.b, 0)  # Start transparent
	fade_overlay_color_rect.show()  # Make the ColorRect visible
	var tween = get_tree().create_tween()
	tween.finished.connect(_on_fade_out_finished)
	tween.tween_property(fade_overlay_color_rect, "modulate:a", 1, duration)  # Tween alpha to 1

## Handler for tween finished signal, from fade_out
func _on_fade_out_finished() -> void:
	curtain_faded_out.emit()
	
# Immediately set the screen to dark (no fading)
func fade_dark() -> void:
	fade_overlay_color_rect.modulate = Color(0, 0, 0, 1)  # Set to black with full opacity
	fade_overlay_color_rect.show()  # Ensure the curtain is visible

# Reset the effect to no transition, essentially hiding the curtain
func fade_reset() -> void:
	fade_overlay_color_rect.modulate = Color(0, 0, 0, 0)  # Fully transparent
	fade_overlay_color_rect.hide()  # Hide the curtain
