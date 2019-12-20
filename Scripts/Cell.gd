extends Spatial

onready var animplayer = $AnimationPlayer;
onready var mesh = $MeshInstance;

onready var game = find_parent("Game");
onready var characters = game.get_node("Ingame/Characters").get_children();
onready var obstacles = game.get_node("Ingame/Obstacles").get_children();
onready var selection_arrow = game.get_node("Ingame/Selection_Arrow");

var grid_pos

var selected = false
var highlighted = false


func is_in_array(value, array):
	
	for x in array:
		if x == value:
			return(true)
	return(false)

#Function that checks wether or not another cell is reachable within 
#a given amount of steps
func in_range(char_range): 
	
	if game.selected_player.cur_cell == null:
		return(true);
	if abs(game.selected_player.cur_cell.grid_pos.x - grid_pos.x) + abs(game.selected_player.cur_cell.grid_pos.y - grid_pos.y) < char_range + 1:
		return(true);
	pass;

#The highlight function
func highlight():
	if !highlighted:
		animplayer.play('cell_highlighted');
		highlighted = true;

#The de-highlight function
func lowlight():
	if highlighted:
		animplayer.play('cell_lowlighted');
		highlighted = false;

func _on_StaticBody_mouse_entered():
	game.moused_cell = self;
	highlight();
	game.get_node("UI/Debug_button").text = "X: " + str(grid_pos.x) + " " + "Y: " + str(grid_pos.y);
	
func _on_StaticBody_mouse_exited():
	game.moused_cell = null;
	
	if game.selected_player == null or game.selected_player.cur_action == null:
		lowlight()
	else:
		if !is_in_array(grid_pos, game.selected_player.reachable):
			lowlight()

	
	pass;
	


func _on_StaticBody_input_event(camera, event, click_position, click_normal, shape_idx):
	
	
	if Input.is_action_just_pressed('click'):
		animplayer.stop(); #Animation stuff on-click
		animplayer.play('cell_clicked');
		selected = !selected
		game.selected_cell = self;
		
		for player in characters: #code for selecting players
			if player.cur_cell == self:
				game.select_entity(player);
				selection_arrow.translation = game.selected_player.translation + 3 * game.selected_player.entity_offset;
				
				for cell in get_parent().get_children():
					if cell.highlighted:
						cell.lowlight();
		
		if game.selected_player != null and game.selected_player.cur_action != null:
			game.selected_player.cur_action.action(self);


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "cell_clicked" && highlighted:
		animplayer.play('cell_highlighted');

func _process(delta):
	
	characters = game.characters;
	obstacles = game.obstacles;
	
	pass;
