extends Spatial

onready var animplayer = $AnimationPlayer;
onready var mesh = $MeshInstance;
var selected = false


var game


func _ready():
	game = find_parent("Game");



func _on_StaticBody_mouse_entered():
	animplayer.play('cell_selected');
	selected = true;
	#print_debug("entered " + name);
	
func _on_StaticBody_mouse_exited():
	animplayer.play('cell_deselected');
	selected = false;


func _on_StaticBody_input_event(camera, event, click_position, click_normal, shape_idx):
	if Input.is_action_just_pressed('click'):
		animplayer.stop();
		animplayer.play('cell_clicked');
		

		find_parent("Game").get_node("Player").change_player_cell(self.get_path());
		
		
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "cell_clicked" && selected:
		animplayer.play('cell_selected');
