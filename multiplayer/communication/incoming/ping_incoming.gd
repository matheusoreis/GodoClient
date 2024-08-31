class_name PingIncoming extends RefCounted


func handle(message : ServerMessage, _scene_tree: SceneTree) -> void:
	print(message.get_content())
