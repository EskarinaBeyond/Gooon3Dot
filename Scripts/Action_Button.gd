extends Button

onready var game = find_parent("Game");

func _ready():
	pass




func _on_Action_Button_1_button_down():
	if game.selected_player != null:
		if game.selected_player.actions.size() > self.get_index():
			game.select_action(game.selected_player.actions[self.get_index()], game.selected_player);
	
	for button in get_parent().get_children():
		if button != self:
			button.pressed = false;
