class_name AccessAccountIncoming extends Node


func handle(_message : ServerMessage, scene_tree: SceneTree) -> void:
	AccessAccountCore.new().core(scene_tree)
