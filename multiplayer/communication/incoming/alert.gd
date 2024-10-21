class_name Alert extends RefCounted


func handle(message : ServerMessage, scene_tree: SceneTree) -> void:
	var alert_message: String = message.get_string()
	var should_disconnect: int = message.get_int8()

	var core: AlertCore = AlertCore.new()
	core.scene_tree = scene_tree
	core.alert_message = alert_message
	core.should_disconnect = should_disconnect
