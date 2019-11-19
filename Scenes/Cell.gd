extends MeshInstance

var animplayer
var selected = false


func _ready():
	animplayer= $AnimationPlayer



func _on_StaticBody_mouse_entered():
	print('entered' + name);
	animplayer.play('cell_selected');
	selected = true;
	
func _on_StaticBody_mouse_exited():
	print('exited' + name);
	animplayer.play('cell_deselected');
	selected = false;


#func _on_StaticBody_input_event(camera, event, click_position, click_normal, shape_idx):
	#print('clicked' + name);



