extends Button

onready var game = find_parent("Game");

func _ready():
	pass




func _on_Action_Button_1_button_down():
	if game.selected_player != null:
		game.selected_player.cur_action = game.selected_player.actions[self.get_index()];
