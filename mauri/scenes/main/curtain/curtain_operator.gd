class_name CurtainOperator extends Resource
## Curtain operator allows controlling the curtain from different scenes
## as long the same resource is used by the Curtain.

@export var fade_duration: float = 1.0 # Default fade duration
var curtain : Curtain = null

## Sets the curtain
func set_curtain(p_curtain : Curtain) -> void:
	curtain = p_curtain


# Setter for the fade color
func set_curtain_label_text(p_text: String) -> void:
	if curtain == null:
		push_warning("CurtainOperator: curtain is null")
		return 
	curtain.set_curtain_label_text(p_text)
	
# Setter for the fade color
func set_fade_color(new_color: Color) -> void:
	if curtain == null:
		push_warning("CurtainOperator: curtain is null")
		return 
	curtain.set_fade_color(new_color)

## Fade In the curtain (from black to transparent)
## Returns the used curtain instance for allowing the await pattern to be used
## curtain_operator.fade_out(1.0).curtain_fade_in
func fade_in(duration: float = fade_duration) -> Curtain:
	if curtain == null:
		push_warning("CurtainOperator: curtain is null")
		return 
		
	curtain.fade_in(duration)
	return curtain
	

## Fade Out the curtain (from transparent to black)
## Returns the used curtain instance for allowing the await pattern to be used
## curtain_operator.fade_out(1.0).curtain_faded_out
func fade_out(duration: float = fade_duration) -> Curtain:
	if curtain == null:
		push_warning("CurtainOperator: curtain is null")
		return 
	curtain.fade_out(duration)
	return curtain
	
# Immediately set the screen to dark (no fading)
func fade_dark() -> void:
	if curtain == null:
		push_warning("CurtainOperator: curtain is null")
		return 
	curtain.fade_dark()

# Reset the effect to no transition, essentially hiding the curtain
func fade_reset() -> void:
	if curtain == null:
		push_warning("CurtainOperator: curtain is null")
		return 
	curtain.fade_reset()

## Method for checkign if the curtain is setted for the operator
func is_curtain_setted() -> bool:
	if curtain == null:
		return false
	return true
