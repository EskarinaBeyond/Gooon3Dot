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
	#in_range_new(characters[0].cur_cell, 5, 0);

func erase_from_2d_array_if_higher(array, max_num): #erases all entries from an 2d array, which are larger than the argument
	for x in array.size():
		if array[x].x >= max_num or array[x].y >= max_num:
			array.erase(array[x])
			erase_from_2d_array_if_higher(array, max_num)
			#print(array)
			break
	return(array)

func erase_from_2d_array_if_lower(array, min_num): #erases all entries from an 2d array, which are larger than the argument
	for x in array.size():
		if array[x].x < min_num or array[x].y < min_num:
			array.erase(array[x])
			erase_from_2d_array_if_lower(array, min_num)
			#print(array)
			break
	return(array)

func in_range_new(or_cell, char_range, range_type): 
	#rangetype 0: moving, cant go over obstacles, but through other characters
	#rangetype 1: attack, cant go through obstacles, or other characters
	#rangetype 2: flying goes over obstacles and other characters
	
	var temp_grid = []
	var return_array = []
	char_range += 1;
	
	if range_type == 0:
		
		
		for x in range(2 * char_range + 1):
			temp_grid.append([])
			temp_grid[x].resize(2 * char_range + 1)

			for y in range(2 * char_range + 1):
				temp_grid[x][y] = 0;
		
		var grid_center = Vector2(char_range, char_range);
		temp_grid[grid_center.x][grid_center.y] = 9;
		
		for obstacle in obstacles:
			if abs(obstacle.cur_cell.grid_pos.x - or_cell.grid_pos.x) + abs(obstacle.cur_cell.grid_pos.y - or_cell.grid_pos.y) <= char_range:
				temp_grid[char_range + obstacle.cur_cell.grid_pos.x - or_cell.grid_pos.x][char_range + obstacle.cur_cell.grid_pos.y - or_cell.grid_pos.y] = 2;
		
		for line in temp_grid.size():
			print(temp_grid[line]);
		
		for step in char_range:
			
			
			for x in 2 * char_range + 1:
				for y in 2 * char_range + 1:
					if temp_grid[x][y] == 1:
						
						if y != 2 * char_range + 1:
							if temp_grid[x][y + 1] != 2:
								temp_grid[x][y + 1] = 9;
						
						if y != 0: 
							if temp_grid[x][y - 1] != 2:
								temp_grid[x][y - 1] = 9;
						
						if x != 2 * char_range + 1:
							if temp_grid[x + 1][y] != 2:
								temp_grid[x + 1][y] = 9;
						
						if x != 0:
							if temp_grid[x - 1][y] != 2:
								temp_grid[x - 1][y] = 9;
								
			for x in 2 * char_range + 1:
				for y in 2 * char_range + 1:
					if temp_grid[x][y] == 9:
						temp_grid[x][y] = 1;
						
			print("--------Step " + str(step) + "--------");
			for line in temp_grid.size():
				print(temp_grid[line]);
		
	for x in 2 * char_range + 1:
		for y in 2 * char_range + 1:
			if temp_grid[x][y] == 1:
				return_array.append(Vector2(or_cell.grid_pos.x - char_range + x, or_cell.grid_pos.y - char_range + y));
	
	return_array = erase_from_2d_array_if_higher(return_array, grid.gridxsize)
	return_array = erase_from_2d_array_if_lower(return_array, 0)
	
	print(return_array)
	return(return_array);

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
		


func select_entity(player):
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
	
	for cell in grid.get_children():
		if cell.highlighted:
			cell.lowlight();
	
	player.cur_action = action;
	for pos in in_range_new(player.cur_cell, action.action_range, 0):
		grid.gridarray[pos.x][pos.y].highlight();
		pass;


func _ready():
	calculate_turn_order();

func _process(delta):
	
	characters = get_node("Ingame/Characters").get_children();
	obstacles = get_node("Ingame/Obstacles").get_children();
	enemies = get_node("Ingame/Enemies").get_children();
	
	if Input.is_action_just_pressed("right_click"):
		if selected_player != null:
			if selected_player.cur_action != null:
				
				for cell in grid.get_children():
					if cell.highlighted:
						cell.lowlight();
						
				selected_player.cur_action = null;
	
	if selected_player != null:
		
		if selected_player.cur_action != null:
			pass;
#			for cell in grid.get_children():
#				if cell.in_range(selected_player.cur_action.action_range) and !cell.highlighted:
#					cell.highlight();
					

			
				
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
