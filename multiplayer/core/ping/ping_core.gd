class_name PingCore extends Node


func core(scene_tree: SceneTree, latency: float) -> void:
	var label_node: Label = scene_tree.root.get_node(
		'/root/Main/SharedUI/InfoLocation/ContentVBox/PingLabel'
	)

	if label_node == null:
		return

	var current_ping: String = ''

	if latency < 15:
		current_ping = 'Local'
	else:
		current_ping = str(latency)

	label_node.text = 'Ping: ' + current_ping
