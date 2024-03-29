extends Spatial

onready var game = find_parent("Game");
onready var owner_char = get_parent().get_parent();
onready var characters = game.find_node("Characters").get_children();
onready var obstacles = game.find_node("Obstacles").get_children();
onready var enemies = game.find_node("Enemies").get_children();

export(String) var action_name = "Attack"
export(Image) var action_icon = null;

export(int) var action_range = 1;
export(int) var range_type = 1;
export(int) var damage = 1;
export(int) var ap_cost = 1;


func action(cell):

	if game.selected_player != null:
		
		if game.selected_player.cur_cell != cell and cell.in_range(action_range):
			
			if obstacles.size() > 0:
				
				for obstacle in obstacles:
					if obstacle.cur_cell == cell:
						if damage >= 5:
							obstacle.cur_health -= damage - 5;
							game.selected_player = null;
			
			if enemies.size() > 0:
				
				for enemy in enemies:
					if enemy.cur_cell == cell:
						enemy.cur_health -= damage;
				
			for character in characters:
				if character.cur_cell == cell:
					character.cur_health -= damage;
					game.selected_player = null;
					
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
	enemies = game.enemies;


