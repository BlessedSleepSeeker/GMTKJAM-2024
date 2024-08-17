extends Node
class_name ShifumiOption

func get_win_quote(beaten_option: String) -> String:
	for option: ShifumiBeatenOption in get_children():
		if option.name == beaten_option:
			return option.get_win_quote()
	return "AAAAAAAAAAAAAAAAAAAAA I FUCKED UP"

func unlock_relation(beaten_option: ShifumiBeatenOption) -> void:
	beaten_option.unlocked_result = true