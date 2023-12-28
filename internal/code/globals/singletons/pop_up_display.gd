extends CanvasLayer

enum SCENE {SETTINGS, CREDITS, PAUSE}
var settings_tscn: PackedScene = preload("res://internal/code/menus/settings/settings.tscn")
var credits_tscn: PackedScene = preload("res://internal/code/menus/credits/credits.tscn")
var pause_tscn: PackedScene = preload("res://internal/code/menus/pause/pause.tscn")

var scenes_dict = {
	SCENE.SETTINGS: settings_tscn.instantiate(),
	SCENE.CREDITS: credits_tscn.instantiate(),
	SCENE.PAUSE: pause_tscn.instantiate(),
}

func _init():
	assert(SCENE.size() == scenes_dict.size(), "PopUp scenes aren't equal")

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		self.remove_child(self.get_child(-1))

func call_scene(pop_up: SCENE) -> Node:
	var scene_inst = scenes_dict[pop_up]
	if scene_inst.is_inside_tree():
		self.move_child(scene_inst, -1)
	else:
		self.add_child(scenes_dict[pop_up])
	return scene_inst
