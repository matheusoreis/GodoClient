class_name Alert extends RefCounted


func handle(message : ServerMessage, scene_tree: SceneTree) -> void:
	var alert_message: String = message.get_string()
	var should_disconnect: int = message.get_int8()

	const alert_alert_location: String = 'res://scenes/ui/shared/alert/alert_ui.tscn'
	var alert_preload: PackedScene = preload(alert_alert_location)

	var alert_instantiate: AlertUI = alert_preload.instantiate()
	alert_instantiate.show_alert(scene_tree, alert_message)

	if should_disconnect == 1:
		Multiplayer.websocket.disconnect_from_host()
		return
