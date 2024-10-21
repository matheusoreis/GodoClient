class_name AlertIncoming extends Node


func handle(message : ServerMessage, scene_tree: SceneTree) -> void:
	var alert_message: String = message.get_string()
	var should_disconnect: int = message.get_int8()
	
	AlertCore.new().core(scene_tree, alert_message, should_disconnect)
