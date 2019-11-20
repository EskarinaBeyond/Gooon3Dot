extends Spatial

var animplayer
var selected = false


func _ready():
	animplayer= $AnimationPlayer



func _on_StaticBody_mouse_entered():
	animplayer.play('cell_selected');
	selected = true;
	
func _on_StaticBody_mouse_exited():
	animplayer.play('cell_deselected');
	selected = false;


func _on_StaticBody_input_event(camera, event, click_position, click_normal, shape_idx):
	if Input.is_action_just_pressed('click'):
		animplayer.stop();
		animplayer.play('cell_clicked');

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "cell_clicked" && selected:
		animplayer.play('cell_selected');
