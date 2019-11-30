extends Spatial

onready var selection_arrow = $Ingame/Selection_Arrow;
onready var ingame = $Ingame
onready var grid = $Ingame/Grid

onready var characters = $Ingame/Characters.get_children();
onready var obstacles = $Ingame/Obstacles.get_children();
onready var enemies = $Ingame/Enemies.get_children();

onready var selected_player = null;
onready var cell_selector = $Ingame/Cell_Selector;
onready var ui = $UI;
onready var action_buttons = $UI/Action_Buttons.get_children();
onready var turn_order_ui = $UI/Turn_Order

var selected_cell

var moused_cell

var turn_order = []

func _on_Button_pressed():
	calculate_turn_order();

func calculate_turn_order():
	
	turn_order.clear();
	
	var temp_order = []#creates a temporary array off all player characters and enemies, that will be sorted in the next step
	
	for character in characters:
		temp_order.append(character);
		
	for enemy in enemies:
		temp_order.append(enemy);
		
	while temp_order.size() > 0:#checks for the entity with the highest initiative inside the temp array. that entity will then be appended to the actual turn order
		
		var fastest = temp_order[0];
		
		for character in temp_order:
			if character.init > fastest.init:
				fastest = character;
				
		turn_order.append(fastest);
		temp_order.erase(fastest);
	
#	for item in turn_order:
#		if item == null:
#			print_debug("Null")
#		else:
#			print_debug(item.name);
	
	if turn_order_ui.get_child_count() > 0:
		for label in turn_order_ui.get_children():
			label.queue_free();
	
	
	for item in turn_order:
		var label
		label = preload("res://Scenes/Turn_Order_Label.tscn").instance();
		label.text = item.name;
		turn_order_ui.add_child(label, true)
		


func select_player(player):
	selected_player = player;
	
	selection_arrow = find_node("Selection_Arrow");
	selection_arrow.visible = true;
	selection_arrow.translation = player.translation + Vector3(0, 5, 0);
	
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
	enemies = get_node("Ingame/Enemies").get_children();
	
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
