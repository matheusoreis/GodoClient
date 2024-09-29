class_name Pong extends RefCounted


func handle(_message : ServerMessage, scene_tree: SceneTree) -> void:
	var receiver_time: float = Time.get_ticks_msec()
	var latency: float = round(receiver_time - Globals.sender_ping_time)

	const ping_label_location: String = '/root/Main/SharedUI/InfoLocation/ContentVBox/PingLabel'
	var label_node: Label = scene_tree.root.get_node(ping_label_location)

	if label_node == null:
		return

	var current_ping: String = ''

	if latency < 15:
		current_ping = 'Local'
	else:
		current_ping = str(latency)

	label_node.text = 'Ping: ' + current_ping
