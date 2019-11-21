extends Spatial

export(NodePath) var curcell
export(bool) var selfselected
export(float) var player_height = 1.5;

onready var animplayer = $AnimationPlayer
onready var mesh = $MeshInstance




func change_player_cell(cell):
	
	curcell = cell;
	print_debug(get_node(cell).name);
	translation = find_parent("Game").get_node(cell).translation ;
	
func _process(delta):
	
	if get_node(curcell).selected == true and selfselected == false:
		selfselected = true;
		#animplayer.play("Player_Selected");
		
	
	if get_node(curcell).selected == false and selfselected == true:
		selfselected = false;
		#animplayer.play("Player_Deselected");
	
	mesh.translation = find_parent("Game").get_node(curcell).mesh.translation + Vector3(0, player_height, 0);