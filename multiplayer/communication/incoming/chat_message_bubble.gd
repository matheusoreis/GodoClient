class_name ChatMessageBubble extends RefCounted


func handle(server_message : ServerMessage, scene_tree: SceneTree) -> void:
	var senderId: int = server_message.get_int32()
	var senderName: String = server_message.get_string()
	var message: String = server_message.get_string()

	var chat_history_location: String = '/root/Main/GameUI/ChatUI'
	var chat_history_node: ChatUI = scene_tree.root.get_node(
		chat_history_location
	)

	var message_formated: String = '[GLOBAL] ' + senderName + ': ' + message

	chat_history_node.add_history_message(message_formated)
