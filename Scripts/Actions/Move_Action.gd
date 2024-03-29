extends Spatial

onready var game = find_parent("Game");
onready var owner_char = get_parent().get_parent();
onready var characters = game.find_node("Characters").get_children();
onready var obstacles = game.find_node("Obstacles").get_children();

export(String) var action_name = "Move"

export(int) var action_range = 2;
export(int) var range_type = 0
export(int) var ap_cost = 1;

export(Image) var action_icon = null;

func action(cell):

	if game.selected_player != null:
		
		if game.selected_player.cur_cell != cell and cell.is_in_array(cell, owner_char.reachable):
			
			if obstacles.size() > 0:
				
				for obstacle in obstacles:
					if obstacle.cur_cell == cell:
						return;
				
				for character in characters:
					if character.cur_cell == cell:
						return;
						
			owner_char.cur_cell = cell;
			owner_char.translation = cell.translation;
			
			if game.selection_arrow != null:
				game.select_entity(owner_char);
				
			owner_char.cur_action = null;

			for cell in game.find_node("Grid").get_children():
				if cell.highlighted:
					cell.lowlight();
			
			for button in game.find_node("Action_Buttons").get_children():
				button.pressed = false;

func _ready():
	pass

func _process(delta):
	characters = game.characters;
	obstacles = game.obstacles;


