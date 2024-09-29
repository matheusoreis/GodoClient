class_name SelectCharacter extends ClientMessage


func _init(character_id: int) -> void:
	super._init(ClientHeaders.Headers.SELECT_CHARACTER)

	self.put_int32(character_id)
