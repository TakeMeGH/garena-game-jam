extends CanvasLayer

func sleep_transition_enter():
	$AnimationPlayer.play("dissolve")
	await $AnimationPlayer.animation_finished

func sleep_transition_exit():
	$AnimationPlayer.play_backwards("dissolve")
	await $AnimationPlayer.animation_finished
