extends Spatial

export(bool) var highlighted
export(Vector3) var entity_offset = Vector3(0, 1.5, 0);
export(Vector2) var starting_cell = Vector2(1, 1);

onready var game = find_parent("Game");
onready var grid = game.find_node("Grid");
onready var actions = $Actions.get_children();


onready var animplayer = $AnimationPlayer
onready var mesh = $MeshInstance

var cur_cell
var cur_action
var reachable

export(int) var max_health = 3;
onready var cur_health = max_health;

export(int) var max_ap = 3;
onready var cur_ap = max_ap;

export(int) var init = 3





func die():
	self.queue_free();

func _ready():
	cur_cell = grid.gridarray[starting_cell.x][starting_cell.y]
	#cur_action = actions[0];
	#game.selected_player = self;
	game.find_node("Selection_Arrow").translation = self.translation + Vector3(0, 5, 0);
	game.select_entity(self);
	game.select_action(actions[0], self)
	cur_action.action(grid.gridarray[starting_cell.x][starting_cell.y]);
	game.selected_player = null;
	cur_action = null;
	pass;

func _process(delta):
	
	if cur_cell != null:
		if cur_cell.highlighted == true and highlighted == false:
			highlighted = true;
		
		if cur_cell.highlighted == false and highlighted == true:
			highlighted = false;
		
		mesh.translation = cur_cell.mesh.translation + entity_offset;
	
	if cur_health <= 0:
		die();
	
	
	