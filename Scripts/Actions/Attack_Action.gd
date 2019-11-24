extends Spatial

onready var game = find_parent("Game");
onready var owner_char = get_parent().get_parent();
onready var characters = game.find_node("Characters").get_children();
onready var obstacles = game.find_node("Obstacles").get_children();

export(String) var action_name = "Attack"
export(Image) var action_icon = null;

export(int) var max_action_charges = 1;
export(int) var action_range = 1;
export(int) var damage = 1;




var action_charges = max_action_charges;

func action(cell):

	if game.selected_player != null:
		
		if game.selected_player.cur_cell != cell and cell.in_range(action_range):
			
			if obstacles.size() > 0:
				
				for obstacle in obstacles:
					if obstacle.cur_cell == cell:
						if damage >= 5:
							obstacle.cur_health -= damage - 5;
							game.selected_player = null;
							return;
				
			for character in characters:
				if character.cur_cell == cell:
					character.cur_health -= damage;
					game.selected_player = null;
					return;
					
			game.selected_player = null;

			for cell in game.find_node("Grid").get_children():
				if cell.highlighted:
					cell.lowlight();

func _ready():
	pass

func _process(delta):
	characters = game.characters;
	obstacles = game.obstacles;


