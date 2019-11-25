extends Spatial

onready var camera = $Camera_Anchor/Camera_A;
onready var selection_arrow = find_node("Selection_Arrow");
onready var ingame = $Ingame
onready var grid = $Ingame/Grid
onready var characters = $Ingame/Characters.get_children();
onready var obstacles = $Ingame/Obstacles.get_children();
onready var selected_player = null;
onready var cell_selector = $Ingame/Cell_Selector;
onready var ui = $UI;
onready var action_buttons = $UI/Action_Buttons.get_children();

var selected_cell

var moused_cell


func select_player(player):
	selected_player = player;
	
	selection_arrow.visible = true;
	selection_arrow.translation = selected_player.translation + 3 * selected_player.entity_offset;
	
	for button in action_buttons:
		button.find_node("Icon").texture = null;
		button.find_node("Label").text = "";
	
	for action in player.actions:
		action_buttons[action.get_index()].find_node("Icon").texture = action.action_icon;
		action_buttons[action.get_index()].find_node("Label").text = action.action_name;
	
func select_action(action, player):
	player.cur_action = action;
	for cell in grid.get_children():
		if cell.in_range(action.action_range):
			cell.highlight();
		else:
			cell.lowlight();


func _ready():
	pass;
	

func _process(delta):
	
	characters = get_node("Ingame/Characters").get_children();
	obstacles = get_node("Ingame/Obstacles").get_children();
	
	if Input.is_action_just_pressed("right_click"):
		if selected_player != null:
			if selected_player.cur_action != null:
				
				for cell in grid.get_children():
					if cell.in_range(selected_player.cur_action.action_range) and cell.highlighted:
						cell.lowlight();
						
				selected_player.cur_action = null;
			else:
				selected_player = null;
	
	if selected_player != null:
		
		if selected_player.cur_action != null:
		
			for cell in grid.get_children():
				if cell.in_range(selected_player.cur_action.action_range) and !cell.highlighted:
					cell.highlight();
					
#				if !cell.in_range(selected_player.cur_action.action_range) and cell.highlighted:
#					cell.lowlight();
			
				
	else:
		selection_arrow.visible = false;
		
		for button in action_buttons:
			button.find_node("Icon").texture = null;
			button.find_node("Label").text = "";
	
	if moused_cell != null:
		cell_selector.visible = true;
		cell_selector.translation = moused_cell.translation + moused_cell.mesh.translation;
	else:
		cell_selector.visible = false;
	
	
	

