extends SubViewportContainer
class_name UiViewport

@export var option_button: PackedScene

func create_option(name: String) -> void:
	var option = option_button.instantiate()
	var option_location = $SubViewport/ButtonPath/ButtonSpawnLocation
	option_location.progress_ratio = randf()
	option.position = option_location.position
	option.find_child('Button').text = name
	add_child(option)
