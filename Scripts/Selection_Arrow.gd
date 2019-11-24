extends Spatial

func _ready():
	$AnimationPlayer.play("Selection_Arrow_Idle");
	pass;





func _on_AnimationPlayer_animation_finished(anim_name):
	$AnimationPlayer.play("Selection_Arrow_Idle");
