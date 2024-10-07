class_name ChatMessage extends ClientMessage


#func _init(channel: int, message: String) -> void:
	#super._init(ClientHeaders.Headers.CHAT_MESSAGE)
#
	#self.put_int8(channel)
	#self.put_string(message)
